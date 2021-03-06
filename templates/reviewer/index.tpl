{**
 * index.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Reviewer index.
 *
 * $Id$
 *}
{strip}
{assign var="pageTitle" value="common.reviewer.queue.long.$pageToDisplay"}
{include file="common/header.tpl"}
{/strip}

<ul class="nav nav-tabs">
	<li{if ($pageToDisplay == "active")} class="current active"{/if}><a href="{url path="active"}">{translate key="common.reviewer.queue.short.active"}</a></li>
	<li{if ($pageToDisplay == "completed")} class="current active"{/if}><a href="{url path="completed"}">{translate key="common.reviewer.queue.short.completed"}</a></li>
</ul>

<br />

{include file="reviewer/$pageToDisplay.tpl"}

{include file="common/footer.tpl"}
