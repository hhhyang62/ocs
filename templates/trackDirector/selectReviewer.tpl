{**
 * selectReviewer.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List reviewers and give the ability to select a reviewer.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="director.paper.selectReviewer"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
  document.submit.sort.value = heading;
  document.submit.sortDirection.value = direction;
  document.submit.submit() ;
}
// -->
{/literal}
</script> 

<!--<h3>{translate key="director.paper.selectReviewer"}</h3>-->
<form name="submit" method="post" action="{url op="selectReviewer" path=$paperId}">
	<input type="hidden" name="sort" value="name"/>
	<input type="hidden" name="sortDirection" value="ASC"/>
	<select name="searchField" size="1" class="selectMenu">
		{html_options_translate options=$fieldOptions selected=$searchField}
	</select>
	<select name="searchMatch" size="1" class="selectMenu">
		<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
		<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
		<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
	</select>
	<input type="text" size="10" name="search" class="textField" value="{$search|escape}" />&nbsp;<input type="submit" value="{translate key="common.search"}" class="button" />
</form>

<p>{foreach from=$alphaList item=letter}<a href="{url op="selectReviewer" path=$paperId searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="selectReviewer" path=$paperId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>


<div id="reviewers">
<table class="listing" width="100%">
{assign var=numCols value=7}
{if $rateReviewerOnQuality}
	{assign var=numCols value=$numCols+1}
{/if}
<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>
<tr class="heading" valign="bottom">
	<td>{sort_search key="user.name" sort="reviewerName"}</td>
	<td>
            {*translate key="user.interests"*}
            擅長領域 {* @TODO 語系 *}
        </td>
	{if $rateReviewerOnQuality}
		<td>{sort_search key="reviewer.averageQuality" sort="quality"}</td>
	{/if}
	<td>{sort_search key="reviewer.completedReviews" sort="done"}</td>
	<td>{sort_search key="director.submissions.averageTime" sort="average"}</td>
	<td>{sort_search key="director.submissions.lastAssigned" sort="latest"}</td>
	<td>{sort_search key="director.submissions.active" sort="active"}</td>
	<td class="heading" align="right">{translate key="common.action"}</td>
</tr>
<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>
{iterate from=reviewers item=reviewer}
{assign var="userId" value=$reviewer->getId()}
{assign var="qualityCount" value=$averageQualityRatings[$userId].count}
{assign var="reviewerStats" value=$reviewerStatistics[$userId]}

<tr valign="top">
	<td><a class="action" href="{url op="userProfile" path=$userId}">{$reviewer->getFullName()|escape}</a></td>
	<td>{$reviewer->getLocalizedInterests()|escape}</td>
	{if $rateReviewerOnQuality}<td>
		{if $qualityCount}
                    {$averageQualityRatings[$userId].average|string_format:"%.1f"}
		{else}
                    {*translate key="common.notApplicableShort"*}
                    &mdash;
                {/if}
	</td>{/if}

	<td>
		{if $completedReviewCounts[$userId]}
                    <a href="{url op="submissions" path="submissionsAll"}?searchField=4&searchMatch=is&search={$reviewer->getFullName()|escape}"
                       target="_blank">
			{$completedReviewCounts[$userId]}
                        </a>
		{else}
			0
		{/if}
	</td>

	<td>
		{if $reviewerStats.average_span}
			{math equation="round(theSpan)" theSpan=$reviewerStats.average_span}
		{else}
			&mdash;
		{/if}
	</td>
	<td>{if $reviewerStats.last_notified}{$reviewerStats.last_notified|date_format:$dateFormatShort}{else}&mdash;{/if}</td>
	<td>
            <a href="{url op="submissions" path="submissionsInReview"}?searchField=4&searchMatch=is&search={$reviewer->getFullName()|escape}"
                   target="_blank">
                {$reviewerStats.incomplete|default:0}
            </a>
        </td>
	<td align="right">
		{if $reviewer->review_id}
			{translate key="common.alreadyAssigned"}
		{else}
                    <a class="btn btn-default btn-sm" href="{url op="selectReviewer" path=$paperId|to_array:$reviewer->getId()}">{translate key="common.assign"}</a>
		{/if}
	</td>
</tr>
<tr><td colspan="{$numCols|escape}" class="{if $reviewers->eof()}end{/if}separator">&nbsp;</td></tr>
{/iterate}
{if $reviewers->wasEmpty()}
<tr>
<td colspan="{$numCols|escape}" class="nodata">{translate key="manager.people.noneEnrolled"}</td>
</tr>
<tr><td colspan="{$numCols|escape}" class="endseparator">&nbsp;</td></tr>
{else}
	<tr>
		<td colspan="2" align="left">{page_info iterator=$reviewers}</td>
		<td colspan="{$numCols-2}" align="right">{page_links anchor="reviewers" name="reviewers" searchInitial=$searchInitial iterator=$reviewers searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>


<p class="text-center hide" style="margin: 15px 0;">
    <a class="btn btn-primary" href="{url op="createReviewer" path=$paperId}">{translate key="trackDirector.review.createReviewer"}</a>
    
    <a class="btn btn-default" href="{url op="enrollSearch" path=$paperId}">{translate key="trackDirector.review.enrollReviewer"}</a>
</p>

<h4>{translate key="common.notes"}</h4>
<p>{translate key="director.paper.selectReviewerNotes"}</p>
</div>
{include file="common/footer.tpl"}
