<cfset application.components = StructNew() />

<cfset path = ListToArray(cgi.path_translated, "\\") />
<cfset path[ArrayLen(path)] = "components" />

<cfset comps = DirectoryList(ArrayToList(path, "\"), true, 'path', "*.cfc") />

<cfloop array="#comps#" index="c">
	<cfset temp = ListToArray(c, "\\") />
	<cfset component = temp[ArrayLen(temp)] />
	<cfset component = ListToArray(component, "\.")[1] />

	<cfset application.components[component] = createObject("component", "components." & component) />
</cfloop>
