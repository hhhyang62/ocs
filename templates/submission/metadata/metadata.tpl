{**
 * metadata.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission metadata table. Non-form implementation.
 *
 * $Id$
 *}
<div id="metadata">
<!--
<h3>{translate key="submission.metadata"}</h3>
-->

<div id="titleAndAbstract">
<!--
<h4>{translate key="submission.titleAndAbstract"}</h4>
-->

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="paper.title"}</td>
		<td width="80%" class="value">{$submission->getLocalizedTitle()|strip_unsafe_html|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td class="label">{translate key="paper.abstract"}</td>
		<td class="value">{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>
</table>
</div><!-- titleAndAbstract -->

<div id="authors">
<!--
<h4>{translate key="paper.authors"}</h4>
    -->
<table width="100%" class="data">
	{foreach name=authors from=$submission->getAuthors() item=author}
        <!--
	<tr valign="top">
		<td width="20%" class="label">
                    {translate key="author.submit.selectPrincipalContact"}
                    {*translate key="user.name"*}
                </td>
		<td width="80%" class="value">
			{assign var=emailString value=$author->getFullName()|concat:" <":$author->getEmail():">"}
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags paperId=$submission->getPaperId()}
                        <a href="{$url}" class="btn btn-default">
                            <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                            {$author->getFullName()|escape} 
                            {*icon name="mail" url=$url*}
                        </a>
		</td>
	</tr>
        -->
        {if $author->getAuthorBiography()}
        <tr valign="top">
		<td class="label" width="20%">
                    {*translate key="user.authorProfile"*}
                    作者基本資訊資訊
                </td>
		<td width="80%" class="value">{$author->getAuthorBiography()|escape|default:"&mdash;"}</td>
	</tr>
        {/if}
        <!--
	{if $author->getUrl()}
		<tr valign="top">
			<td class="label">{translate key="user.url"}</td>
			<td class="value"><a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a></td>
		</tr>
	{/if}
        <tr valign="top">
		<td class="label">{translate key="user.affiliation"}</td>
		<td class="value">{$author->getAffiliation()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>
	<tr valign="top">
		<td class="label">{translate key="common.country"}</td>
		<td class="value">{$author->getCountryLocalized()|escape|default:"&mdash;"}</td>
	</tr>
	<tr valign="top">
		<td class="label">{translate key="user.biography"}</td>
		<td class="value">{$author->getAuthorBiography()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
	</tr>
	{if $author->getPrimaryContact()}
		<tr valign="top">
			<td colspan="2" class="label">{translate key="author.submit.selectPrincipalContact"}</td>
		</tr>
	{/if}
	{if !$smarty.foreach.authors.last}
		<tr>
			<td colspan="2" class="separator">&nbsp;</td>
		</tr>
	{/if}
        -->
	{/foreach}
</table>
</div><!-- authors -->


<!--
<div id="indexing">
<h4>{translate key="submission.indexing"}</h4>
	
<table width="100%" class="data">
	{if $currentSchedConf->getSetting('metaDiscipline')}
	<tr valign="top">
		<td width="20%" class="label">{translate key="paper.discipline"}</td>
		<td width="80%" class="value">{$submission->getLocalizedDiscipline()|escape|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	{/if}
	{if $currentSchedConf->getSetting('metaSubjectClass')}
	<tr valign="top">
		<td width="20%"  class="label">{translate key="paper.subjectClassification"}</td>
		<td width="80%" class="value">{$submission->getLocalizedSubjectClass()|escape|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	{/if}
	{if $currentSchedConf->getSetting('metaSubject')}
	<tr valign="top">
		<td width="20%"  class="label">{translate key="paper.subject"}</td>
		<td width="80%" class="value">{$submission->getLocalizedSubject()|escape|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	{/if}
	{if $currentSchedConf->getSetting('metaCoverage')}
	<tr valign="top">
		<td width="20%"  class="label">{translate key="paper.coverageGeo"}</td>
		<td width="80%" class="value">{$submission->getLocalizedCoverageGeo()|escape|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td class="label">{translate key="paper.coverageChron"}</td>
		<td class="value">{$submission->getLocalizedCoverageChron()|escape|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td class="label">{translate key="paper.coverageSample"}</td>
		<td class="value">{$submission->getLocalizedCoverageSample()|escape|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	{/if}
	{if $currentSchedConf->getSetting('metaType')}
	<tr valign="top">
		<td width="20%"  class="label">{translate key="paper.type"}</td>
		<td width="80%" class="value">{$submission->getLocalizedType()|escape|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	{/if}
	<tr valign="top">
		<td width="20%" class="label">{translate key="paper.language"}</td>
		<td width="80%" class="value">{$submission->getLanguage()|escape|default:"&mdash;"}</td>
	</tr>
</table>
</div>
-->        
<!-- indexing -->
<!--
<div id="supportingAgencies">
<h4>{translate key="submission.supportingAgencies"}</h4>
	
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="submission.agencies"}</td>
		<td width="80%" class="value">{$submission->getLocalizedSponsor()|escape|default:"&mdash;"}</td>
	</tr>
</table>
</div>
-->
<!-- supportingAgencies -->

{if $currentSchedConf->getSetting('metaCitations')}
	<div id="citations">
	<h4>{translate key="submission.citations"}</h4>

	<table width="100%" class="data">
		<tr valign="top">
			<td width="20%" class="label">{translate key="submission.citations"}</td>
			<td width="80%" class="value">{$submission->getCitations()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
		</tr>
	</table>
	</div><!-- citations -->
{/if}


{if $mayEditPaper}
    <p class="text-center">
	<a href="{url op="viewMetadata" path=$submission->getPaperId()}" class="action btn btn-primary">
            {translate key="submission.editMetadata"}
        </a>
    </p>
{/if}

</div>
