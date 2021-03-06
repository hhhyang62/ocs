{**
 * submissionsArchives.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show listing of submission archives.
 *
 * $Id$
 *}
{if $tracks|@count > 1}
    {assign var="colspan" value=8}
{else}
    {assign var="colspan" value=7}
{/if}
<div id="submissions">

<table width="100%" class="listing">
	<tr>
		<td colspan="{$colspan}" class="headseparator">&nbsp;</td>
	</tr>
	<tr class="heading" valign="bottom">
		<td width="5%">{sort_search key="common.id" sort="id"}</td>
                {if $tracks|@count > 1}
		<td>{sort_search key="submissions.track" sort="track"}</td>
                {/if}
		<td>{sort_search key="paper.sessionType" sort="sessionType"}</td>
		<td>{sort_search key="paper.authors" sort="authors"}</td>
		<td>{sort_search key="paper.title" sort="title"}</td>
		<!-- <td>{sort_search key="common.status" sort="status"}</td> -->
                <td>{translate key="director.paper.selectReviewer"}</td>
		<td>{translate key="common.order"}</td>
                <td>{translate key="submissions.manage"}</td>
	</tr>
	
	{iterate from=submissions item=submission}

	<tr>
		{if !$lastTrackId}
			<td colspan="{$colspan}" class="headseparator">&nbsp;</td>
			{assign var=notFirst value=1}
		{elseif $lastTrackId != $submission->getTrackId()}
			<td colspan="{$colspan}" class="headseparator">&nbsp;</td>
		{else}
			<td colspan="{$colspan}" class="separator">&nbsp;</td>
		{/if}
		{assign var=lastTrackId value=$submission->getTrackId()}
	</tr>

	{assign var="paperId" value=$submission->getPaperId()}
	<input type="hidden" name="paperIds[]" value="{$paperId|escape}" />
	<tr valign="top"  class="listing-tr">
		<td>{$paperId|escape}</td>
                {if $tracks|@count > 1}
		<td>{$submission->getTrackAbbrev()|escape}</td>
                {/if}
		<td>
			{assign var="sessionTypeId" value=$submission->getData('sessionType')}
			{if $sessionTypeId}
				{assign var="sessionType" value=$sessionTypes.$sessionTypeId}
                                {if $sessionType|is_object}
                                    {assign var="sessionName" value=$sessionType->getLocalizedName()}
                                    {if $sessionName|strlen < 12}
                                        {$sessionName|escape}
                                        {else}
                                        {$sessionName|escape|substr:0:12}...
                                    {/if}
                                {else}
                                    &mdash;
                                {/if}
			{/if}
		</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submissionReview" path=$paperId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."|default:"&mdash;"}</a></td>
		
                <!--
		<td>
			{assign var="status" value=$submission->getStatus()}
			{if $status == STATUS_ARCHIVED}
				{translate key="submissions.archived"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$paperId}" onclick="return confirm('{translate|escape:"jsparam" key="director.submissionArchive.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
			{elseif $status == STATUS_PUBLISHED}
				{translate key="submissions.published"}
			{elseif $status == STATUS_DECLINED}
				{translate key="submissions.declined"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$paperId}" onclick="return confirm('{translate|escape:"jsparam" key="director.submissionArchive.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
			{/if}
		</td>
                -->
                <td >
                    {assign var="stage" value=2}
                    {assign var=reviewAssignments value=$submission->getReviewAssignments($stage)}
                    {if $reviewAssignments|@count === 0} 
                        &mdash;
                    {else}
                        {assign var="hasReview" value=0}
                        {foreach from=$reviewAssignments item=reviewAssignment key=reviewKey}
                            {assign var=reviewerRecommendationOptions value=$reviewAssignment->getReviewerRecommendationOptions()}
                            {if not $reviewAssignment->getCancelled()}
                            {assign var="hasReview" value=1}
                            <a href="{url op="submissionAssignReviewer" path=$submission->getPaperId()|to_array:$submission->getCurrentStage()}#peerReview{$reviewAssignment->getId()}" 
                               class="btn btn-default btn-sm"
                               target="_blank"
                               title="{$reviewAssignment->getReviewerFullName()|escape}">
                                {if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== '' and $reviewAssignment->getDateCompleted()}
                                    {assign var="recommendation" value=$reviewAssignment->getRecommendation()}
                                    <span 
                                        {if $recommendation == 1}
                                            class="text-success"
                                        {elseif $recommendation == 5 or $recommendation == 6 or $recommendation == 4}
                                            class="text-danger"
                                        {else}
                                            class="text-warning"
                                        {/if}>
                                        {translate key=$reviewerRecommendationOptions.$recommendation}
                                    </span>
                            {else}
                                &mdash;
                            {/if}
                            </a>
                            {/if}
                        {/foreach}
                        {if $hasReview===0}
                            &mdash;
                        {/if}
                    {/if}
                </td>
                
                <td>
			<a href="{url op="movePaper" d=u paperId=$submission->getPaperId()}" class="plain">&uarr;</a>
			<a href="{url op="movePaper" d=d paperId=$submission->getPaperId()}" class="plain">&darr;</a>
		</td>
                <td>
                    <a href="{url op="submissionReview" path=$submission->getPaperId()|to_array:$submission->getCurrentStage()}" class="action">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    </a>
                </td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="{$colspan}" class="headseparator">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="{$colspan}" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
	<tr>
		<td colspan="{$colspan}" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="{$colspan}" class="endseparator">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="{$colspan-3}" align="left">{page_info iterator=$submissions}</td>
		<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search track=$track sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>
