# -*- tcl -*-
# # ## ### ##### ######## ############# #####################

## Buildpack entity definition

# # ## ### ##### ######## ############# #####################

package require Tcl 8.5
package require TclOO
package require stackato::v2::base

# # ## ### ##### ######## ############# #####################

debug level  v2/buildpack
debug prefix v2/buildpack {[debug caller] | }

# # ## ### ##### ######## ############# #####################

stackato v2 register buildpack
oo::class create ::stackato::v2::buildpack {
    superclass ::stackato::v2::base
    # # ## ### ##### ######## #############
    ## Life cycle

    constructor {{url {}}} {
	debug.v2/buildpack {}

	my Attribute name     string
	my Attribute position integer
	my Attribute enabled  boolean

	next $url
	debug.v2/buildpack {/done}
    }

    method upload! {zip} {
	debug.v2/buildpack {}
	[authenticated] upload-by-url-zip [my url]/bits $zip
	return
    }

    # # ## ### ##### ######## #############
    # SearchableOn name -- In essence class-level forwards.

    classmethod list-by-name  {name {depth 0}} { my list-filter name $name $depth }
    classmethod first-by-name {name {depth 0}} { lindex [my list-by-name $name $depth] 0 }
    classmethod find-by-name  {name {depth 0}} { my find-by name $name $depth }

    # # ## ### ##### ######## #############
}

# # ## ### ##### ######## ############# #####################
package provide stackato::v2::buildpack 0
return
