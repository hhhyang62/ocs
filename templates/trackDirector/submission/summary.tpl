{**
 * summary.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission summary table.
 *
 * $Id$
 *}
<div id="submission">
<h3>{translate key="paper.submission"}</h3>

<table width="100%" class="data">
	<tr>
		<td width="20%" class="label">{translate key="paper.authors"}</td>
		<td width="80%">
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() paperId=$submission->getPaperId()}
			{*$submission->getAuthorString()|escape} {icon name="mail" url=$url*}
                        <a href="{$url}" class="btn btn-default">
                            <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                            {$submission->getAuthorString()|escape} 
                            {*icon name="mail"*}
                        </a>
		</td>
	</tr>
	<tr>
		<td class="label">{translate key="paper.title"}</td>
		<td>{$submission->getLocalizedTitle()|strip_unsafe_html|default:"&mdash;"}</td>
	</tr>
        {if $tracks|@count > 1}
	<tr>
		<td class="label">{translate key="track.track"}</td>
		<td>{$submission->getTrackTitle()|escape}</td>
	</tr>
        {/if}
	<tr>
		<td class="label">{translate key="user.role.director"}</td>
		<td>
			{assign var=editAssignments value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}
				{assign var=emailString value=$editAssignment->getDirectorFullName()|concat:" <":$editAssignment->getDirectorEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags paperId=$submission->getPaperId()}
                                <a href="{$url}" class="btn btn-default">
                                    <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                    {$editAssignment->getDirectorFullName()|escape} 
                                    {*icon name="mail" url=$url*}
                                </a>
			{foreachelse}
				{translate key="common.noneAssigned"}
			{/foreach}
		</td>
	</tr>
</table>
</div>
