{**
 * step5.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 5 of author paper submission.
 *
 * $Id$
 *}
{if $showAbstractSteps && $currentSchedConf->getSetting('acceptSupplementaryReviewMaterials') && !$showPaperSteps}
	{assign var="pageTitle" value="author.submit.step5SkipSupp"}
{elseif $currentSchedConf->getSetting('acceptSupplementaryReviewMaterials') && !$showAbstractSteps}
	{assign var="pageTitle" value="author.submit.step5"}
{else}
	{assign var="pageTitle" value="author.submit.step5"}
{/if}
{include file="author/submit/submitHeader.tpl"}

<div>
{if $isConferenceManager}
    <a class="edit-link" href="{url page="manager"}/schedConfSetup/2#stepFinalMessageTr" target="_blank">
        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
    </a>
{/if}
{if $stepFinalMessage}
    {$stepFinalMessage}
{else}
    <p>{translate key="author.submit.confirmationDescription" conferenceTitle=$conference->getConferenceTitle()}</p>
{/if}
</div>


<form method="post" action="{url op="saveSubmit" path=$submitStep}">
<input type="hidden" name="paperId" value="{$paperId|escape}" />

<h3>{translate key="author.submit.filesSummary"}</h3>
<table class="listing" width="100%">
<tr>
	<td colspan="4" class="headseparator">&nbsp;</td>
</tr>
<tr class="heading" valign="bottom">
	<!-- <td width="10%">{translate key="common.id"}</td> -->
	<td width="35%">{translate key="common.originalFileName"}</td>
	<td width="25%">{translate key="common.type"}</td>
	<td width="20%" class="nowrap">{translate key="common.fileSize"}</td>
	<td width="10%" class="nowrap">{translate key="common.dateUploaded"}</td>
</tr>
<tr>
	<td colspan="4" class="headseparator">&nbsp;</td>
</tr>
{foreach from=$files item=file}
<tr valign="top">
	<!-- <td>{$file->getFileId()}</td> -->
	<td><a class="file" href="{url op="download" path=$paperId|to_array:$file->getFileId()}">{$file->getOriginalFileName()|escape}</a></td>
	<td>{if ($file->getType() == 'supp')}{translate key="paper.suppFile"}{else}{translate key="author.submit.submissionFile"}{/if}</td>
	<td>{$file->getNiceFileSize()}</td>
	<td>{$file->getDateUploaded()|date_format:$dateFormatTrunc}</td>
</tr>
{foreachelse}
<tr valign="top">
<td colspan="4" class="nodata">{translate key="author.submit.noFiles"}</td>
</tr>
{/foreach}
</table>

<div class="separator"></div>

<p class="text-center">
    <input type="submit" value="{translate key="author.submit.finishSubmission"}" class="btn btn-primary" /> 
    <input type="button" value="{translate key="common.tempSave"}" class="btn btn-default" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" />
</p>

</form>

{include file="common/footer.tpl"}
