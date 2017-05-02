<#include "common.ftl"/>
<#include "markings.ftl"/>

<#macro renderVesselType defaultName format='long' lang='en'>
    <#if params.wreck_type?has_content>
        <#assign desc=descForLang(params.wreck_type, lang)!>
        <#if desc?? && format == 'long'>
            ${desc.longValue?cap_first}
        <#elseif desc??>
            ${desc.value?cap_first}
        <#else>
            ${defaultName?cap_first}
        </#if>
    <#else>
        ${defaultName?cap_first}
    </#if>
</#macro>

<@defaultSubjectFieldTemplates/>

<field-template field="part.getDesc('da').details" format="html">
    <@renderVesselType defaultName="et skib" format="long" lang="da"/>
    er sunket <@renderPositionList geomParam=part lang="da"/>.
    Dybden over vraget er <#if params.wreck_depth??>${params.wreck_depth} m.<#else>ukendt.</#if>
    Vraget er <@renderMarkings markings=params.markings! lang="da" format="details" unmarkedText="ikke afmærket"/><br>
    Det tilrådes skibsfarten at holde godt klar.
</field-template>

<field-template field="part.getDesc('en').details" format="html">
    <@renderVesselType defaultName="a vessel" format="long" lang="en"/>
    has sunk <@renderPositionList geomParam=part lang="en"/>.
    The depth above the wreck is <#if params.wreck_depth??>${params.wreck_depth} m.<#else>unknown.</#if>
    The wreck is <@renderMarkings markings=params.markings! lang="en" format="details" unmarkedText="unmarked"/><br>
    Mariners are advised to keep well clear.
</field-template>

<#if promulgate('audio')>
    <field-template field="message.promulgation('audio').text" update="append">
        <@line>
            <@renderVesselType defaultName="et skib" format="long" lang="da"/>
            er sunket <@renderPositionList geomParam=part format="audio" lang="da"/>.
            Dybden over vraget er <#if params.wreck_depth??>${params.wreck_depth} m.<#else>ukendt.</#if>
            Vraget er <@renderMarkings markings=params.markings! lang="da" format="audio"  unmarkedText="ikke afmærket"/>
        </@line>
        <@line>
            Det tilrådes skibsfarten at holde godt klar.
        </@line>
    </field-template>
</#if>

<#if promulgate('navtex')>
    <field-template field="message.promulgation('navtex').text" update="append">
        <@line format="navtex">
            <@renderVesselType defaultName="A VESSEL" format="short" lang="en"/>
            SUNK <@renderPositionList geomParam=part format="navtex" lang="en"/>.
            DEPTH ABOVE WRECK <#if params.wreck_depth??>${params.wreck_depth}M.<#else>UNKNOWN.</#if>
            WRECK <@renderMarkings markings=params.markings! lang="en" format="navtex"  unmarkedText="UNMARKED"/>
        </@line>
        <@line format="navtex">
            MARINERS ADVISED TO KEEP CLEAR.
        </@line>
    </field-template>
</#if>