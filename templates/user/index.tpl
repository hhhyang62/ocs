{**
 * index.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User index.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="user.userHome"}
{include file="common/header.tpl"}
{/strip}

{if $isSiteAdmin}
{assign var="hasRole" value=1}
	&#187; <a href="{url conference="admin" page=$isSiteAdmin->getRolePath()}">{translate key=$isSiteAdmin->getRoleName()}</a>
	{call_hook name="Templates::User::Index::Admin"}
{/if}

{if !$currentConference}<h3>{translate key="user.myConferences"}</h3>{/if}

{foreach from=$userConferences item=conference}
{assign var="hasRole" value=1}
{assign var=lastColSpan value=4}
{if !$schedConfPostPayment}
    {assign var=lastColSpan value=$lastColSpan-1}
{/if}
<div id="conference">
    {if !$currentConference}
    <h4><a href="{url conference=$conference->getPath() page="user"}">{$conference->getConferenceTitle()|escape}</a></h4>
    {/if}
    
	{assign var="conferenceId" value=$conference->getId()}
	{assign var="conferencePath" value=$conference->getPath()}
	{* Display conference roles *}
	
	<table width="100%" class="info">
		{if $isValid.ConferenceManager.$conferenceId.0}
			<tr>
				<td>&#187; <a href="{url conference=$conferencePath page="manager"}">{translate key="user.role.manager"}</a></td>
				<td></td>
				<td></td>
				<td></td>
				<td align="right">{if $setupIncomplete.$conferenceId}[<a href="{url conference=$conferencePath schedConf=$schedConfPath  page="manager" op="setup" path="1"}">{translate key="manager.schedConfSetup"}</a>]{/if}</td>
			</tr>
		{/if}
	</table>

	{* Display scheduled conference roles *}
	{foreach from=$userSchedConfs[$conferenceId] item=schedConf}
		<div id="schedConf">
		{assign var="schedConfId" value=$schedConf->getId()}
		{assign var="schedConfPath" value=$schedConf->getPath()}
                {if !$currentConference}
                    <h5><a href="{url conference=$conference->getPath() schedConf=$schedConf->getPath() page="index"}">{$schedConf->getSchedConfTitle()|escape}</a></h5>
                {/if}

		<table width="100%" class="info table table-striped">
                    <thead>
                        <tr>
                            <th rowspan="2">
                                {translate key="user.roles"}
                            </th>
                            <th rowspan="2">
                                {translate key="user.userHome.progressAuthor"}
                            </th> 
                            <th colspan="3">
                                {translate key="submissions.reviewAssignment.heading"}
                            </th>
                            {if $schedConfPostPayment}
                            <th rowspan="2">
                                {translate key="common.queue.short.registration"}
                            </th>
                            {/if}
                            <th rowspan="2" style="text-align:right">
                                {translate key="submissions.manage"}
                            </th>
                        </tr>
                        <tr>
                            <th>
                                {translate key="user.userHome.progressWaitAssign"}
                            </th> 
                            <th>
                                {translate key="user.userHome.progressWaitReview"}
                            </th> 
                            <th>
                                {translate key="user.userHome.progressAccepted"}
                            </th> 
                        </tr>
                    </thead>
                    <tbody>
                        {if $isValid.Author.$conferenceId.$schedConfId}
				{assign var="authorSubmissionsCount" value=$submissionsCount.Author.$conferenceId.$schedConfId}
				<tr>
					<th valign="top"><a href="{url conference=$conferencePath schedConf=$schedConfPath  page="author"}">{translate key="user.role.author"}</a></th>
					<td>{if $authorSubmissionsCount[0]}
							<a href="{url conference=$conferencePath schedConf=$schedConfPath  page="author"}">{$authorSubmissionsCount[0]} {translate key="common.queue.count.active"}</a>
						{else}<span class="disabled">0 {translate key="common.queue.count.active"}</span>{/if}
					</td>
                                        <td colspan="{$lastColSpan}"></td>
					<td align="right">[<a href="{url conference=$conferencePath schedConf=$schedConfPath  page="author" op="submit"}">{translate key="author.submit"}</a>]</td>
				</tr>
			{/if}
			{if $isValid.Director.$conferenceId.$schedConfId}
				<tr>
					{assign var="directorSubmissionsCount" value=$submissionsCount.Director.$conferenceId.$schedConfId}
					<th valign="top"><a href="{url conference=$conferencePath schedConf=$schedConfPath  schedConf=$schedConfPath page="director"}">{translate key="user.role.director"}</a></th>
                                        <td>&nbsp;</td>
					<td>
                                            {if $directorSubmissionsCount[1]}
                                                <a href="{url conference=$conferencePath schedConf=$schedConfPath  page="director" op="submissions" path="submissionsUnassigned"}">
                                                    {$directorSubmissionsCount[1]} 
                                                    {translate key="common.queue.count.submissionsUnassigned"}</a>
                                            {else}
                                                <span class="disabled">0 {translate key="common.queue.count.submissionsUnassigned"}</span>
                                            {/if}
					</td>
					<td>
						{if $directorSubmissionsCount[2]}
							<a href="{url conference=$conferencePath schedConf=$schedConfPath  page="director" op="submissions" path="submissionsInReview"}">
                                                            {$directorSubmissionsCount[2]} {translate key="common.queue.count.submissionsInReview"}
                                                        </a>
						{else}
							<span class="disabled">0 {translate key="common.queue.count.submissionsInReview"}</span>
						{/if}
					</td>
                                        <td>
                                            {if $directorSubmissionsCount[3]}
                                                <a href="{url conference=$conferencePath schedConf=$schedConfPath  page="director" op="submissions" path="submissionsAccepted"}">
                                                    {$directorSubmissionsCount[3]}
                                                    {translate key="common.queue.count.submissionsAccepted"}
                                                </a>
                                            {else}
                                                <span class="disabled">0 {translate key="common.queue.short.submissionsAccepted"}</span>
                                            {/if}
                                        </td>
                                        {if $schedConfPostPayment}
                                        <td>
                                            {if $directorSubmissionsCount[5]}
                                                <a href="{url conference=$conferencePath schedConf=$schedConfPath  page="manager" op="registration"}">
                                                    {$directorSubmissionsCount[5]}
                                                    {translate key="common.queue.count.registration"}
                                                </a>
                                            {else}
                                                <span class="disabled">0 {translate key="common.queue.count.registration"}</span>
                                            {/if}
                                            
                                        </td>
                                        {/if}
					<td align="right">[<a href="{url conference=$conferencePath schedConf=$schedConfPath  page="director" op="notifyUsers"}">{translate key="director.notifyUsers"}</a>]</td>
				</tr>
			{/if}
			{if $isValid.TrackDirector.$conferenceId.$schedConfId && !($isValid.Director.$conferenceId.$schedConfId && $isValid.TrackDirector.$conferenceId.$schedConfId) }
				{assign var="trackDirectorSubmissionsCount" value=$submissionsCount.TrackDirector.$conferenceId.$schedConfId}
				<tr>
					<th valign="top"><a href="{url conference=$conferencePath schedConf=$schedConfPath  page="trackDirector"}">{translate key="user.role.trackDirector"}</a></th>
					<td colspan="2">&nbsp;</td>
					<td colspan="{$lastColSpan-1}">
						{if $trackDirectorSubmissionsCount[0]}
							<a href="{url conference=$conferencePath schedConf=$schedConfPath  page="trackDirector" op="index" path="submissionsInReview"}">{$trackDirectorSubmissionsCount[0]} {translate key="common.queue.short.submissionsInReview"}</a>
						{else}
							<span class="disabled">0 {translate key="common.queue.count.submissionsInReview"}</span>
						{/if}
					</td>
				</tr>
			{/if}
			{*if $isValid.Author.$conferenceId.$schedConfId || $isValid.Reviewer.$conferenceId.$schedConfId}
				<tr><td class="separator" width="100%" colspan="5">&nbsp;</td></tr>
			{/if*}
			
			{if $isValid.Reviewer.$conferenceId.$schedConfId}
				{assign var="reviewerSubmissionsCount" value=$submissionsCount.Reviewer.$conferenceId.$schedConfId}
				<tr>
					<th valign="top"><a href="{url conference=$conferencePath schedConf=$schedConfPath  page="reviewer"}">{translate key="user.role.reviewer"}</a></th>
                                        <td colspan="2">&nbsp;</td>
                                        <td>{if $reviewerSubmissionsCount[0]}
							<a href="{url conference=$conferencePath schedConf=$schedConfPath  page="reviewer"}">{$reviewerSubmissionsCount[0]} {translate key="common.queue.count.active"}</a>
						{else}<span class="disabled">0 {translate key="common.queue.count.active"}</span>{/if}
					</td>
                                        <td colspan="{$lastColSpan-1}">&nbsp;</td>
				</tr>
			{/if}
			{* Add a row to the bottom of each table to ensure all have same width*}
			{*}<tr>
				<td width="25%"></td>
				<td width="14%"></td>
				<td width="14%"></td>
				<td width="14%"></td>
				<td width="33%"></td>
			</tr>{*}
                    </tbody>	
		</table>
	</div>
	{/foreach}

	{call_hook name="Templates::User::Index::Conference" conference=$conference}
	</div>
{/foreach}


{if !$hasRole}
	{if !$currentSchedConf}
		<p>{translate key="user.noRoles.chooseConference"}</p>
		{foreach from=$allConferences item=thisConference key=conferenceId}
			<h4>{$thisConference->getConferenceTitle()|escape}</h4>
			{if !empty($allSchedConfs[$conferenceId])}
			<ul class="plain">
			{foreach from=$allSchedConfs[$conferenceId] item=thisSchedConf key=schedConfId}
				<li>&#187; <a href="{url conference=$thisConference->getPath() schedConf=$thisSchedConf->getPath() page="user" op="index"}">{$thisSchedConf->getSchedConfTitle()|escape}</a></li>
			{/foreach}
			</ul>
			{/if}{* !empty($allSchedConfs[$conferenceId]) *}
		{/foreach}
	{else}{* !$currentSchedConf *}
		<p>{translate key="user.noRoles.noRolesForConference"}</p>
		<ul class="plain">
			<li>
				&#187;
				{if $allowRegAuthor}
					{if $submissionsOpen}
						<a href="{url page="author" op="submit"}">{translate key="user.noRoles.submitProposal"}</a>
					{else}{* $submissionsOpen *}
						{translate key="user.noRoles.submitProposalSubmissionsClosed"}
					{/if}{* $submissionsOpen *}
				{else}{* $allowRegAuthor *}
					{translate key="user.noRoles.submitProposalRegClosed"}
				{/if}{* $allowRegAuthor *}
			</li>
			<li>
				&#187;
				{if $allowRegReviewer}
					{url|assign:"userHomeUrl" page="user" op="index"}
					<a href="{url op="become" path="reviewer" source=$userHomeUrl}">{translate key="user.noRoles.regReviewer"}</a>
				{else}{* $allowRegReviewer *}
					{translate key="user.noRoles.regReviewerClosed"}
				{/if}{* $allowRegReviewer *}
			</li>
			<li>
				&#187;
				{if $schedConfPaymentsEnabled}
					<a href="{url page="schedConf" op="registration"}">{translate key="user.noRoles.register"}</a>
				{else}{* $schedConfPaymentsEnabled *}
					{translate key="user.noRoles.registerUnavailable"}
				{/if}{* $schedConfPaymentsEnabled *}
			</li>
		</ul>
	{/if}{* !$currentSchedConf *}
{/if}

<div id="myAccount">
<h3>{translate key="user.myAccount"}</h3>
<ul class="plain">
	{if $hasOtherConferences}
		{if !$showAllConferences}
			<li>&#187; <a href="{url conference="admin" page="user"}">{translate key="user.showAllConferences"}</a></li>
		{/if}
	{/if}
	<li>&#187; <a href="{url page="user" op="profile"}">{translate key="user.editMyProfile"}</a></li>
	<li>&#187; <a href="{url page="user" op="changePassword"}">{translate key="user.changeMyPassword"}</a></li>
	<li>&#187; <a href="{url page="login" op="signOut"}">{translate key="user.logOut"}</a></li>
	{call_hook name="Templates::User::Index::MyAccount"}
</ul>
</div>

{include file="common/footer.tpl"}
