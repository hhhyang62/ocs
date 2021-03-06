{**
 * header.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *
 *}
{strip}
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{if $pageCrumbTitle}
	{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated}
	{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
{/if}
{/strip}<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<title>{$pageTitleTranslated}</title>
	<meta name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	{$metaCustomHeaders}
	{if $displayFavicon}
            <link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />
        {else}
            <link rel="icon" href="{$baseUrl}/favicon.ico" type="image/x-icon" />
        {/if}
	
        <link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
        
	<!-- Base Jquery -->
	{*if $allowCDN}<script src="http://www.google.com/jsapi"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		//google.load("jquery", "1.9.0");
		google.load("jqueryui", "1");
	</script>
	{else}
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if*}
        {**
         * @author Pulipuli Chen 不使用CDN 20160122
         *}
        <script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	<!-- Add javascript required for font sizer -->
        
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="{$baseUrl}/lib/bootstrap/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="{$baseUrl}/lib/bootstrap//css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="{$baseUrl}/lib/bootstrap/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

        <!-- affix-sidebar -->
        <link href="{$baseUrl}/lib/affix-sidebar/css/styles.css" rel="stylesheet">
        <script src="{$baseUrl}/lib/affix-sidebar/js/scripts.js"></script>
	

	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/jquery.cookie.js"></script>	
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/fontController.js" ></script>
	<script type="text/javascript">{literal}
		$(function(){
			fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$baseUrl}{literal}"); // Initialize the font sizer
		});
	{/literal}</script>
	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	{if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}
	{if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/general.js"></script>
        
        <script type="text/javascript" src="{$baseUrl}/lib/puli-units/helpers.js"></script>
	{$additionalHeadData}
</head>

<body>
{include file="common/nav.tpl"}
{if $requestedPage=="user" 
or $requestedPage=="admin" 
or $requestedPage=="login" 
or $requestedPage=="manager" 
or $requestedPage=="author" 
or $requestedPage=="director" 
or $requestedPage=="trackDirector" 
or $requestedPage=="reader"
or $requestedPage=="reviewer"} 
    {assign var="isCompact" value="compact"}
{/if}
<div id="container" class="header-container {$isCompact}">

<div id="masthead">  
<div class="container">
        <div class="row"
             style="min-height: 250px;background-repeat:no-repeat;background-size: 100%;
             {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
             background-image:url({$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"});
             {else}
             background-image:url({$baseUrl}/lib/pkp/styles/images/book-978880_1920.gif);
             {/if}">

            <div class="col-sm-9 well well-lg">
{if $isConferenceManager}
    <a class="edit-link" href="{url page="manager"}/setup/3#conferenceTitleInfo" target="_blank">
        {*translate key="manager.registrationOptions.editTitle"*}
        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
    </a>
{/if}
                <h1>
                    <a href="{$currentConferenceHome}">
                    {if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
                            <img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" 
                                 width="{$displayPageHeaderTitle.width|escape}" 
                                 height="{$displayPageHeaderTitle.height|escape}" 
                                 {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
                    {elseif $displayPageHeaderTitle}
                        {if !$isCompact}
                            {$displayPageHeaderTitle}
                        {else}
                            {$displayPageHeaderTitle|@strip_tags}
                        {/if}
                    {elseif $alternatePageHeader}
                            {$alternatePageHeader}
                    {elseif $customLogoTemplate}
                            {include file=$customLogoTemplate}
                    {elseif $siteTitle}
                            {$siteTitle}
                    {else}
                            {$applicationName}
                    {/if}
                    
                    {if $displayPageHeaderSubTitle}
                        <div class="sub-title">{$displayPageHeaderSubTitle}</div>
                    {/if}
                    </a>
                </h1>    
            </div>
        </div>
         </div>
    </div> {*<div class="container">*}
</div> {*<div id="header">*}

<div id="body" class="container">

<div class="col-sm-9 col-sm-push-3">
{include file="common/breadcrumbs.tpl"}

{if $isConferenceManager & $isIndex}
    <a class="edit-link" href="{url page="manager"}/editSchedConf/{$conferenceId}/{$schedConfId}" target="_blank">
        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
    </a>
{/if}
<h2>{$pageTitleTranslated}</h2>

{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
{if $pageSubtitleTranslated}
	<h3>{$pageSubtitleTranslated}</h3>
{/if}

<div id="content">
