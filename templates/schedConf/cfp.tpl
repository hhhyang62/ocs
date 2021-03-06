{**
 * cfp.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Scheduled conference call-for-papers page.
 *
 * $Id$
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="schedConf.cfp.title"}
{include file="common/header.tpl"}
{/strip}

{if $isConferenceManager}
    <div class="panel panel-primary">
        <h3 class="panel-heading">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            {translate key="manager.conferenceSiteManagement"}</h3>
        <div class="panel-body">

            <ul>
                <li>
                    <a href="{url page="manager"}/schedConfSetup/1#principalContact" target="_blank">
                        {translate key="common.edit"}
                        {translate key="about.contact.principalContact"}
                    </a>
                </li>
                <li>
                    <a href="{url page="manager"}/emails" target="_blank">
                        {translate key="common.edit"}
                        {translate key="manager.emails"}
                    </a>
                </li>
                <li>
                    <a href="{url page="manager"}/editEmail/SUBMISSION_ACK" target="_blank">
                        {translate key="common.edit"}
                        {translate key="manager.emails"}
                        SUBMISSION_ACK
                    </a>
                </li>
                <li>
                    <a href="{url page="manager"}/editEmail/SUBMISSION_UPLOAD_ACK" target="_blank">
                        {translate key="common.edit"}
                        {translate key="manager.emails"}
                        SUBMISSION_UPLOAD_ACK
                    </a>
                </li>
                <li>
                    <a href="{url page="manager"}/editEmail/SUBMISSION_ACK_BCC" target="_blank">
                        {translate key="common.edit"}
                        {translate key="manager.emails"}
                        SUBMISSION_ACK_BCC
                    </a>
                </li>
                <li>
                    <a href="{url page="manager"}/editEmail/SUBMISSION_UPLOAD_ACK_BCC" target="_blank">
                        {translate key="common.edit"}
                        {translate key="manager.emails"}
                        SUBMISSION_UPLOAD_ACK_BCC
                    </a>
                </li>
                <li>
                    <a href="{url page="user"}" target="_blank">
                        {translate key="schedConf.cfp.quickLink.manageSubmission"}
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="separator"></div>
{/if}

<div id="cfp">
{if $isConferenceManager}
    <a class="edit-link" href="{url page="manager"}/schedConfSetup/2#callForPapers" target="_blank">
        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
    </a>
{/if}
<p>{$cfpMessage|nl2br}</p>

{if $authorGuidelines != ''}
<div class="separator"></div>
    {if $isConferenceManager}
        <a class="edit-link" href="{url page="manager"}/schedConfSetup/2#authorGuidelinesInfo" target="_blank">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
        </a>
    {/if}
	<h3>{translate key="about.authorGuidelines"}</h3>
	<p>{$authorGuidelines|nl2br}</p>
{/if}

<div class="separator"></div>

<div class="text-center">
{if $acceptingSubmissions}
	<p>
            <h3>{translate key="author.submit.startHere"}</h3>
            {if $isUserLoggedIn}
                <a href="{url page="author" op="submit" requiresAuthor=1}" class="action btn btn-primary">
                    {translate key="author.submit.startHereLink"}
                </a>
            {else}
                <a href="{url page="user" op="account"}?source=%2Focs%2Ficcisc%2F2016%2Fauthor%2Fsubmit%3FrequiresAuthor%3D1" class="action btn btn-primary">
                    {translate key="schedConf.cfp.createAccount"}
                </a>
                <a href="{url page="author" op="submit" requiresAuthor=1}" class="action btn btn-default">
                    {translate key="user.login"}
                </a>
            {/if}
	</p>
{else}
	<p>
		{$notAcceptingSubmissionsMessage}
	</p>
{/if}
</div>

</div>
{include file="common/footer.tpl"}
