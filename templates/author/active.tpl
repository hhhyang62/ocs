{**
 * active.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the details of active submissions.
 *
 * $Id$
 *}
{assign var="colspan" value=7}
{if $tracks|@count < 2}
    {assign var="colspan" value=$colspan-1}
{/if}
<div id="submissions">
<table class="listing" width="100%">
	<tr><td colspan="{$colspan}" class="headseparator">&nbsp;</td></tr>
	<tr class="heading" valign="bottom">
		<td>{sort_heading key="common.id" sort="id"}</td>
		<td><!--<span class="disabled">MM-DD</span><br />-->{sort_heading key="submissions.submit" sort="submitDate"}</td>
		<td>{sort_heading key="submissions.track" sort="track"}</td>
		<td>{sort_heading key="paper.authors" sort="authors"}</td>
		<td>{sort_heading key="paper.title" sort="title"}</td>
		<td align="right">{sort_heading key="common.status" sort="status"}</td>
                <td>{translate key="submissions.manage"}</td>
	</tr>
	<tr><td colspan="{$colspan}" class="headseparator">&nbsp;</td></tr>

{iterate from=submissions item=submission}
	{assign var="paperId" value=$submission->getPaperId()}
	{assign var="currentStage" value=$submission->getCurrentStage()}
	{assign var="submissionProgress" value=$submission->getSubmissionProgress()}
	{assign var="status" value=$submission->getSubmissionStatus()}

	<tr valign="top"  class="listing-tr">
		<td>{$paperId|escape}</td>
		<td>{if $submission->getDateSubmitted()}{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>{$submission->getTrackAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		{if $submissionProgress == 0}
			<td><a href="{url op="submission" path=$paperId}" class="action">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</a></td>
			<td align="right">
				{if $status == STATUS_QUEUED_UNASSIGNED}
                                    {translate key="submissions.queuedUnassigned"}
                                    {assign var="submitUrl" value=0}
				{elseif $status == STATUS_QUEUED_REVIEW}
					{assign var=decision value=$submission->getMostRecentDecision()}
					{if $currentStage==REVIEW_STAGE_PRESENTATION}
						<a href="{url op="submissionReview" path=$paperId|to_array}" class="action">
							{if $decision == $smarty.const.SUBMISSION_DIRECTOR_DECISION_PENDING_REVISIONS}{translate key="author.submissions.queuedPaperReviewRevisions"}
							{else}{translate key="submissions.queuedPaperReview"}
							{/if}
						</a>
					{else}
						<a href="{url op="submissionReview" path=$paperId|to_array}" class="action">
							{if $decision == $smarty.const.SUBMISSION_DIRECTOR_DECISION_PENDING_REVISIONS}{translate key="author.submissions.queuedAbstractReviewRevisions"}

							{else}{translate key="submissions.queuedAbstractReview"}
							{/if}
						</a>
					{/if}
                                        {url|assign:"submitUrl" op="submissionReview" path=$paperId|to_array}
				{elseif $status == STATUS_QUEUED_EDITING}
					<a href="{url op="submissionReview" path=$paperId|to_array}" class="action">{translate key="submissions.queuedEditing"}</a>
                                        {url|assign:"submitUrl" op="submissionReview" path=$paperId|to_array}
				{/if}
			</td>
                        <td>
                            {if $submitUrl !== 0}
                                <a href="{$submitUrl}" class="action">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                </a>
                            {else}
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            {/if}
                                
                        </td>
		{else}
			{url|assign:"submitUrl" op="submit" path=$submission->getSubmissionProgress() paperId=$paperId}
			<td><a href="{$submitUrl}" class="action">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</a></td>
			<td align="right">
				{if $currentStage == REVIEW_STAGE_ABSTRACT || ($currentStage == REVIEW_STAGE_PRESENTATION && $submissionProgress < 2)}
					{translate key="submissions.incomplete"}
					<br />
					<a href="{url op="deleteSubmission" path=$paperId}" class="action" onclick="return confirm('{translate|escape:"jsparam" key="author.submissions.confirmDelete"}')">
						{translate key="common.delete"}
					</a>
				{else}
					<a class="action" href="{$submitUrl}">{translate key="submissions.pendingPresentation"}</a>
				{/if}	
			</td>
                        <td>
                            <a href="{$submitUrl}" class="action">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            </a>
                        </td>
		{/if}
	</tr>

	<tr>
		<td colspan="{$colspan}" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="{$colspan}" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
	<tr>
		<td colspan="{$colspan}" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="{$colspan-2}" align="left">{page_info iterator=$submissions}</td>
		<td colspan="2" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>