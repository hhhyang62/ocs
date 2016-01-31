{**
 * peerReview.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the peer review table.
 *
 * $Id$
 *}

<div id="peerReview">

{if ($stage == REVIEW_STAGE_PRESENTATION && $submission->getCurrentStage() != REVIEW_STAGE_PRESENTATION)}
	{assign var="isStageDisabled" value=true}
{/if}

{if $isStageDisabled}
	<table class="data" width="100%">
		<tr valign="middle">
			<td><h3>{translate key="submission.peerReview"}</h3></td>
		</tr>
		<tr>
			<td><span class="instruct">{translate key="director.paper.stageDisabled"}</span></td>
		</tr>
	</table>
{else}
	<table class="data" width="100%">
		<tr valign="middle">
			<td width="30%">
				{if $submission->getReviewMode() == $smarty.const.REVIEW_MODE_BOTH_SIMULTANEOUS}
					<h3>{translate key="submission.review"}</h3>
				{elseif $stage == REVIEW_STAGE_ABSTRACT}
					<h3>{translate key="submission.abstractReview"}</h3>
				{else}{* REVIEW_STAGE_PRESENTATION *}
					<h3>{translate key="submission.paperReview"}</h3>
				{/if}
			</td>
			<td width="70%" class="nowrap">
				
			</td>
		</tr>
	</table>

	{assign var="start" value="A"|ord}
	{foreach from=$reviewAssignments item=reviewAssignment key=reviewKey}
	{assign var="reviewId" value=$reviewAssignment->getId()}

	{if not $reviewAssignment->getCancelled()}
		{assign var="reviewIndex" value=$reviewIndexes[$reviewId]}
		<!--div class="separator"></div-->

		<table class="data" width="100%">
		<tr>
			<td width="20%"><h4>{translate key="user.role.reviewer"} {$reviewIndex+$start|chr}</h4></td>
			<td width="34%"><h4>{$reviewAssignment->getReviewerFullName()|escape}</h4></td>
			<td width="46%">
					{if not $reviewAssignment->getDateNotified()}
						<a href="{url op="clearReview" path=$submission->getPaperId()|to_array:$reviewAssignment->getId()}" class="action">{translate key="director.paper.clearReview"}</a>
					{elseif $reviewAssignment->getDeclined() or not $reviewAssignment->getDateCompleted()}
						<a href="{url op="cancelReview" paperId=$submission->getPaperId() reviewId=$reviewAssignment->getId()}" class="action">{translate key="director.paper.cancelReview"}</a>
					{/if}
			</td>
		</tr>
		</table>

		<table width="100%" class="data">
		<tr valign="top">
		<td class="label">{translate key="submission.reviewForm"}</td>
		<td>
		{if $reviewAssignment->getReviewFormId()}
			{assign var="reviewFormId" value=$reviewAssignment->getReviewFormId()}
			{$reviewFormTitles[$reviewFormId]}
		{else}
			{translate key="manager.reviewForms.noneChosen"}
		{/if}
		{if !$reviewAssignment->getDateCompleted()}
			&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="{url op="selectReviewForm" path=$submission->getPaperId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.paper.confirmChangeReviewForm"}')"{/if}>{translate key="editor.paper.selectReviewForm"}</a>{if $reviewAssignment->getReviewFormId()}&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="{url op="clearReviewForm" path=$submission->getPaperId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.paper.confirmChangeReviewForm"}')"{/if}>{translate key="editor.paper.clearReviewForm"}</a>{/if}
		{/if}
		</td>
	</tr>
		<tr valign="top">
                    <td class="label" width="20%">
                        {* @TODO 語系 *}
                        審查進度
                    </td>
			<td width="80%">
				<table width="100%" class="info">
					<tr>
						<td class="heading" width="25%">{translate key="submission.request"}</td>
						<td class="heading" width="25%">{translate key="submission.underway"}</td>
						<td class="heading" width="25%">
                                                    {*translate key="submission.due"*}
                                                    審查期限
                                                </td>
						<td class="heading" width="25%">{translate key="submission.acknowledge"}</td>
					</tr>
					<tr valign="top">
						<td>
							{url|assign:"reviewUrl" op="notifyReviewer" reviewId=$reviewAssignment->getId() paperId=$submission->getPaperId()}
							{if !$allowRecommendation}
								{icon name="mail" url=$reviewUrl disabled="true"}
							{elseif $reviewAssignment->getDateNotified()}
								{$reviewAssignment->getDateNotified()|date_format:$dateFormatShort}
								{if !$reviewAssignment->getDateCompleted()}
									{icon name="mail" url=$reviewUrl}
								{/if}
							{else}
								{icon name="mail" url=$reviewUrl}
							{/if}
						</td>
						<td>
							{$reviewAssignment->getDateConfirmed()|date_format:$dateFormatShort|default:"&mdash;"}
						</td>
						<td>
							{if $reviewAssignment->getDeclined()}
								{translate key="trackDirector.regrets"}
							{else}
								<a href="{url op="setDueDate" path=$reviewAssignment->getPaperId()|to_array:$reviewAssignment->getId()}">
                                                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                                                {if $reviewAssignment->getDateDue()}{$reviewAssignment->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}
                                                                </a>
							{/if}
						</td>
						<td>
							{url|assign:"thankUrl" op="thankReviewer" reviewId=$reviewAssignment->getId() paperId=$submission->getPaperId()}
							{if $reviewAssignment->getDateAcknowledged()}
								{$reviewAssignment->getDateAcknowledged()|date_format:$dateFormatShort}
							{elseif $reviewAssignment->getDateCompleted()}
                                                            <a href="{$thankUrl}" class="btn btn-primary">
                                                                <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                                                寫信
                                                            </a>
							{else}
                                                            等待完成審查
							{/if}
						</td>
					</tr>
				</table>
			</td>
		</tr>

		{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
			<tr valign="top">
				<td class="label">
                                    {*translate key="reviewer.paper.recommendation"*}
                                    審查建議 {* @TODO 語系 *}
                                </td>
				<td>
					{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
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
                                                
						&nbsp;&nbsp;
                                                ({$reviewAssignment->getDateCompleted()|date_format:$dateFormatShort})
					{else}
						{translate key="common.none"}
                                                &nbsp;&nbsp;&nbsp;&nbsp;
						<a href="{url op="remindReviewer" paperId=$submission->getPaperId() reviewId=$reviewAssignment->getId()}" class="action">{translate key="reviewer.paper.sendReminder"}</a>
						{if $reviewAssignment->getDateReminded()}
							&nbsp;&nbsp;{$reviewAssignment->getDateReminded()|date_format:$dateFormatShort}
							{if $reviewAssignment->getReminderWasAutomatic()}
								&nbsp;&nbsp;
                                                                {translate key="reviewer.paper.automatic"}
							{/if}
						{/if}
					{/if}
				</td>
			</tr>
			<tr valign="top">
				<td class="label">
                                    {*translate key="submission.review"*}
                                    審查意見
                                </td>
				<td>
					{if $reviewAssignment->getMostRecentPeerReviewComment()}
						{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
						<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getPaperId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span>
                                                    檢視審查意見
                                                </a>
                                                    &nbsp;&nbsp;
                                                    ({$comment->getDatePosted()|date_format:$dateFormatShort})
					{else}
						<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getPaperId()|to_array:$reviewAssignment->getId()}');" class="btn btn-primary">
                                                    <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span>
                                                    檢視審查意見
                                                </a>
                                                    &nbsp;&nbsp;
                                                    {*translate key="submission.comments.noComments"*}
                                                    {* @TODO 語系 *}
                                                    (沒有審查意見)
					{/if}
				</td>
			</tr>
			{if $reviewFormResponses[$reviewId]}
			<tr valign="top">
				<td class="label">
                                    {translate key="submission.reviewFormResponse"}
                                </td>
				<td>
					<a href="javascript:openComments('{url op="viewReviewFormResponse" path=$submission->getPaperId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="letter"}</a>
				</td>
			</tr>
			{/if}
			<tr valign="top">
				<td class="label">
                                    {translate key="reviewer.paper.uploadedFile"}
                                </td>
				<td>
					<table width="100%" class="data">
						{foreach from=$reviewAssignment->getReviewerFileRevisions() item=reviewerFile key=key}
						<tr valign="top">
							<td valign="middle">
								<form name="authorView{$reviewAssignment->getId()}" method="post" action="{url op="makeReviewerFileViewable"}">
									<a href="{url op="downloadFile" path=$submission->getPaperId()|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
									<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
									<input type="hidden" name="paperId" value="{$submission->getPaperId()}" />
									<input type="hidden" name="fileId" value="{$reviewerFile->getFileId()}" />
									<input type="hidden" name="revision" value="{$reviewerFile->getRevision()}" />
									{translate key="director.paper.showAuthor"} <input type="checkbox" name="viewable" value="1"{if $reviewerFile->getViewable()} checked="checked"{/if} />
									<input type="submit" value="{translate key="common.record"}" class="button" />
								</form>
							</td>
						</tr>
						{foreachelse}
						<tr valign="top">
							<td>{translate key="common.none"}</td>
						</tr>
						{/foreach}
					</table>
				</td>
			</tr>
		{/if}

		{if (($reviewAssignment->getRecommendation() === null || $reviewAssignment->getRecommendation() === '') || !$reviewAssignment->getDateConfirmed()) && $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined()}
			<tr valign="top">
				<td class="label">{translate key="reviewer.paper.directorToEnter"}</td>
				<td>
					{if !$reviewAssignment->getDateConfirmed()}
						<a href="{url op="confirmReviewForReviewer" path=$submission->getPaperId()|to_array:$reviewAssignment->getId() accept=1}" class="action">{translate key="reviewer.paper.canDoReview"}</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="confirmReviewForReviewer" path=$submission->getPaperId()|to_array:$reviewAssignment->getId() accept=0}" class="action">{translate key="reviewer.paper.cannotDoReview"}</a><br />
					{/if}
					<form method="post" action="{url op="uploadReviewForReviewer"}" enctype="multipart/form-data">
						{translate key="director.paper.uploadReviewForReviewer"}
						<input type="hidden" name="paperId" value="{$submission->getPaperId()}" />
						<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}"/>
						<input type="file" name="upload" class="uploadField" />
						<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
					</form>
					{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
						<a class="action" href="{url op="enterReviewerRecommendation" paperId=$submission->getPaperId() reviewId=$reviewAssignment->getId()}">{translate key="director.paper.recommendation"}</a>
					{/if}
				</td>
			</tr>
		{/if}

		{if $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined() && $rateReviewerOnQuality}
			<tr valign="top">
				<td class="label">{translate key="director.paper.rateReviewer"}</td>
				<td>
					<form method="post" action="{url op="rateReviewer"}">
					<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
					<input type="hidden" name="paperId" value="{$submission->getPaperId()}" />
					<!-- {translate key="director.paper.quality"}&nbsp; -->
                                        <select name="quality" size="1" class="btn btn-default" onchange="this.form.submit()">
						{html_options_translate options=$reviewerRatingOptions selected=$reviewAssignment->getQuality()}
					</select>&nbsp;&nbsp;
					<input type="submit" value="{translate key="common.record"}" class="button hide" />
					{if $reviewAssignment->getDateRated()}
						&nbsp;&nbsp;({$reviewAssignment->getDateRated()|date_format:$dateFormatShort})
					{/if}
				</form>
				</td>
			</tr>
		{/if}
	</table>
	{/if}
	{/foreach}
{/if}

<div class="text-center" style="margin-top: 15px;">
            <a href="{url op="selectReviewer" path=$submission->getPaperId()}" class="btn btn-primary">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                {*translate key="director.paper.selectReviewer"*}
                {* @TODO 語系 *}
                指定審查委員
            </a>
            <!--
            <a href="{url op="submissionRegrets" path=$submission->getPaperId()}" class="btn btn-danger">
                <span class="glyphicon glyphicon-save-file" aria-hidden="true"></span>
                {translate|escape key="trackDirector.regrets.link"}
            </a>
            -->
        </div>
</div>
