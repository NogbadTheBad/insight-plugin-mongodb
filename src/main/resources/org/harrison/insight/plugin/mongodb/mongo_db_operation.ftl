<#ftl strip_whitespace=true>
<#import "/insight-1.0.ftl" as insight />

<@insight.group label="DB">
    <@insight.entry name="Params" if=operation.args?has_content>
        <@insight.list type="ordered" collection=operation.args />
    </@insight.entry>
    <@insight.entry name="Return">
    	${operation.returnValue?html}
    </@insight.entry>
</@insight.group>

<@insight.sourceCodeLocation location=operation.sourceCodeLocation />
