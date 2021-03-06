# # ## ### ##### ######## ############# #####################
## Copyright (c) 2011-2015 ActiveState Software Inc
## (c) Copyright 2015 Hewlett Packard Enterprise Development LP

## -*- tcl -*-
# # ## ### ##### ######## ############# #####################
## Stackato - Validation Type - Space names
## Dependency: config @client

# # ## ### ##### ######## ############# #####################
## Requisites

package require Tcl 8.5
package require struct::list
package require lambda
package require dictutil
package require cmdr::validate
package require stackato::mgr::client;# pulls v2 also
package require stackato::mgr::corg
package require stackato::mgr::self
package require stackato::validate::common

debug level  validate/spacename
debug prefix validate/spacename {[debug caller] | }

# # ## ### ##### ######## ############# #####################
## Definition

namespace eval ::stackato::validate {
    namespace export spacename
    namespace ensemble create
}

namespace eval ::stackato::validate::spacename {
    namespace export default validate complete release acceptable
    namespace ensemble create

    namespace import ::cmdr::validate::common::complete-enum
    namespace import ::cmdr::validate::common::fail-unknown-simple-msg
    namespace import ::stackato::mgr::corg
    namespace import ::stackato::mgr::self
    namespace import ::stackato::v2
    namespace import ::stackato::validate::common::refresh-client
}

proc ::stackato::validate::spacename::default  {p}   { return {} }
proc ::stackato::validate::spacename::release  {p x} { return }
proc ::stackato::validate::spacename::complete {p x} {
    refresh-client $p
    complete-enum [[corg get] @spaces @name] 0 $x
}

proc ::stackato::validate::spacename::validate {p x} {
    debug.validate/spacename {}

    refresh-client $p

    # See also cspace::get.

    # find space by name in current organization
    set theorg [corg get]
    set matches [$theorg @spaces get* [list q name:$x]]
    # NOTE: searchable-on in v2/space should help
    # (in v2/org using it) to filter server side.

    if {[llength $matches] == 1} {
	# Found, good.
	set x [lindex $matches 0]
	debug.validate/spacename {OK/canon = $x}
	return $x
    }
    debug.validate/spacename {FAIL}
    fail-unknown-simple-msg \
	"[self please spaces Run] to see list of spaces" \
	$p SPACENAME "space" $x " in organization '[$theorg @name]'"
}

# # ## ### ##### ######## ############# #####################
## Ready
package provide stackato::validate::spacename 0
