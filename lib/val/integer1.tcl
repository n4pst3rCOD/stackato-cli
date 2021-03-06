# # ## ### ##### ######## ############# #####################
## Copyright (c) 2011-2015 ActiveState Software Inc
## (c) Copyright 2015 Hewlett Packard Enterprise Development LP

## -*- tcl -*-
# # ## ### ##### ######## ############# #####################
## Stackato - Validation Type - Integer values >= 1

# # ## ### ##### ######## ############# #####################
## Requisites

package require Tcl 8.5
package require cmdr::validate ;# Fail utility command.
package require debug

debug level  validate/integer1
debug prefix validate/integer1 {[debug caller] | }

# # ## ### ##### ######## ############# #####################
## Definition

namespace eval ::stackato::validate {
    namespace export integer1
    namespace ensemble create
}

namespace eval ::stackato::validate::integer1 {
    namespace export default validate complete release
    namespace ensemble create
    namespace import ::cmdr::validate::common::fail
}

proc ::stackato::validate::integer1::default  {p}   { return 1 }
proc ::stackato::validate::integer1::release  {p x} { return }
proc ::stackato::validate::integer1::complete {p x} { return {} }

proc ::stackato::validate::integer1::validate {p x} {
    debug.validate/integer1 {}
    if {[string is integer -strict $x] && ($x >= 1)} { return $x }
    fail $p INTEGER1 "an integer >= 1" $x
}

# # ## ### ##### ######## ############# #####################

# # ## ### ##### ######## ############# #####################
## Ready
package provide stackato::validate::integer1 0
