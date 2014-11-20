<cffunction name="QueryToSelect" access="remote" returnformat="plain" returntype="Any">
	<cfargument name="id" required="true">
	<cfargument name="query" required="true">
	<cfargument name="group" default="" required="false">
	<cfargument name="value" required="true">
	<cfargument name="display" required="true">

	<cftry>
    	<cfset var.previous = "">

		<cfsavecontent variable="select">
			<cfoutput>
            	<select id="#id#">
					<cfloop query="#query#">
						<cfif Evaluate(group) neq var.previous && group neq "">
							<optgroup label="#Evaluate(group)#">
						</cfif>

						<option value="#Evaluate(value)#">#Evaluate(display)#</option>
						<cfset var.previous = Evaluate(group)>

						<cfif Evaluate(group) neq var.previous && group neq "">
							</optgroup>
						</cfif>
					</cfloop>
				</select>
            </cfoutput>
		</cfsavecontent>

		<cfreturn select>
    <cfcatch type="Any">
		<cfdump var="#cfcatch#" />
    </cfcatch>
    </cftry>
</cffunction>

<cfquery name="setData" datasource="YOUR_DATASOURCE">
	select 0 as selectValue, 'Apple' as displayName, 'Fruits' as grouping
	from dual
	union
	select 1 as selectValue, 'Banana' as displayName, 'Fruits' as grouping
	from dual
	union
	select 2 as selectValue, 'Orange' as displayName, 'Fruits' as grouping
	from dual
	union
	select 3 as selectValue, 'Carrots' as displayName, 'Vegetables' as grouping
	from dual
	union
	select 4 as selectValue, 'Lettuce' as displayName, 'Vegetables' as grouping
	from dual
	union
	select 5 as selectValue, 'Grapes' as displayName, 'Vegetables' as grouping
	from dual
	union
	select 6 as selectValue, 'Milk' as displayName, 'Beverages' as grouping
	from dual
	union
	select 7 as selectValue, 'Water' as displayName, 'Beverages' as grouping
	from dual
	union
	select 8 as selectValue, 'Soda' as displayName, 'Beverages' as grouping
	from dual
</cfquery>

<cfquery name="getGroupedData" dbtype="query">
	select * from setData order by grouping asc, displayName asc
</cfquery>

<cfinvoke method="QueryToSelect" returnvariable="groupedSelectHTML">
	<cfinvokeargument name="id" value="grouped_select">
	<cfinvokeargument name="query" value="#getGroupedData#">
	<cfinvokeargument name="group" value="grouping">
	<cfinvokeargument name="value" value="selectValue">
	<cfinvokeargument name="display" value="displayName">
</cfinvoke>

Grouped:<br>
<cfoutput>#groupedSelectHTML#</cfoutput>
<br>

<cfquery name="getNonGroupedData" dbtype="query">
	select * from setData order by displayName asc
</cfquery>

<cfinvoke method="QueryToSelect" returnvariable="nongroupedSelectHTML">
	<cfinvokeargument name="id" value="nongrouped_select">
	<cfinvokeargument name="query" value="#getNonGroupedData#">
	<cfinvokeargument name="value" value="selectValue">
	<cfinvokeargument name="display" value="displayName">
</cfinvoke>

Non-Grouped:<br>
<cfoutput>#nongroupedSelectHTML#</cfoutput>
