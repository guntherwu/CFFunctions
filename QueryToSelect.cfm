<cffunction name="QueryToSelect" returnformat="plain" returntype="any">
  <cfargument name="id" required="true" />
  <cfargument name="query" required="true" />
  <cfargument name="value" required="true" />
  <cfargument name="display" required="true" />
  <cfargument name="group" default="" required="false" />
  
  <cfset var.previous = "" />
  
  <cfsavecontent variable="select">
    <cfoutput>
      <select id="#id#">
        <cfloop query="#query#">
          <cfif Evaluate(group) neq var.previous && group neq "">
            <optgroup label="#Evaluate(group)#">
          </cfif>
          
          <option value="#Evaluate(value)#">#Evaluate(display)#</option>
          <cfset var.previous = Evaluate(group) />
          
          <cfif Evaluate(group) neq var.previous && group neq "">
            </optgroup>
          </cfif>
        </cfloop>
      </select>
    </cfoutput>
  </cfsavecontent>
  
  <cfreturn select />
</cffunction>
