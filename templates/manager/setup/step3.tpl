{**
 * step3.tpl
 *
 * Copyright (c) 2000-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 3 of conference setup.
 *
 * $Id$
 *}
{assign var="pageTitle" value="manager.setup.layout.title"}
{include file="manager/setup/setupHeader.tpl"}

<form name="setupForm" method="post" action="{url op="saveSetup" path="3"}" enctype="multipart/form-data">
    
    <p><span class="formRequired">{translate key="common.requiredField"}</span></p>
{include file="common/formErrors.tpl"}

{if $supportedLocales|@count > 1}
<div id="locales">
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{url|assign:"setupFormUrl" op="setup" path="3" escape=false}
			{form_language_chooser form="setupForm" url=$setupFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
</table>
</div>
{/if}
<div id="homepageHeader">
<h3>3.1 {translate key="manager.setup.layout.homepageHeader"}</h3>

<p>{translate key="manager.setup.layout.homepageHeader.description"}</p>
<ul>
    <li>
        <a href="{url page="schedConf" op="surveyExport"}" target="_blank">
        {translate key="manager.schedConfs.schedulingAConference"}
        </a>
    </li>
</ul>
<div id="conferenceTitleInfo">
<h4>{translate key="manager.setup.layout.conferenceTitle"}</h4>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label"><input type="radio" name="homeHeaderTitleType[{$formLocale|escape}]" id="homeHeaderTitleType-0" value="0"{if not $homeHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="homeHeaderTitleType-0" key="manager.setup.layout.useTextTitle"}</td>
		<td width="80%" class="value">
                    <input type="text" name="homeHeaderTitle[{$formLocale|escape}]" value="{$homeHeaderTitle[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
                    <br />
                    <input type="text" name="homeHeaderSubTitle[{$formLocale|escape}]" value="{$homeHeaderSubTitle[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
                </td>
	</tr>
	<tr valign="top">
		<td width="20%" class="label"><input type="radio" name="homeHeaderTitleType[{$formLocale|escape}]" id="homeHeaderTitleType-1" value="1"{if $homeHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="homeHeaderTitleType-1" key="manager.setup.layout.useImageTitle"}</td>
		<td width="80%" class="value"><input type="file" name="homeHeaderTitleImage" class="uploadField" /> <input type="submit" name="uploadHomeHeaderTitleImage" value="{translate key="common.upload"}" class="button" /></td>
	</tr>
</table>

{if $homeHeaderTitleImage[$formLocale]}
{translate key="common.fileName"}: {$homeHeaderTitleImage[$formLocale].name|escape} {$homeHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteHomeHeaderTitleImage" value="{translate key="common.delete"}" class="button" />
<br />
<img src="{$publicFilesDir}/{$homeHeaderTitleImage[$formLocale].uploadName|escape}" width="{$homeHeaderTitleImage[$formLocale].width|escape}" height="{$homeHeaderTitleImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.homePageHeader.altText"}" />
<br />
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="homeHeaderTitleImageAltText" key="common.altText"}</td>
		<td width="80%" class="value"><input type="text" id="homeHeaderTitleImageAltText" name="homeHeaderTitleImageAltText[{$formLocale|escape}]" value="{$homeHeaderTitleImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td>&nbsp;</td>
		<td class="value"><span class="instruct">{translate key="common.altTextInstructions"}</span></td>
	</tr>
</table>
{/if}
</div>
<div id="conferenceLogoInfo">
<h4>{translate key="manager.setup.layout.conferenceLogo"}</h4>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="manager.setup.layout.useImageLogo"}</td>
		<td width="80%" class="value"><input type="file" name="homeHeaderLogoImage" class="uploadField" /> <input type="submit" name="uploadHomeHeaderLogoImage" value="{translate key="common.upload"}" class="button" /></td>
	</tr>
</table>

{if $homeHeaderLogoImage[$formLocale]}
{translate key="common.fileName"}: {$homeHeaderLogoImage[$formLocale].name|escape} {$homeHeaderLogoImage.dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteHomeHeaderLogoImage" value="{translate key="common.delete"}" class="button" />
<br />
<img src="{$publicFilesDir}/{$homeHeaderLogoImage[$formLocale].uploadName|escape}" width="{$homeHeaderLogoImage[$formLocale].width|escape}" height="{$homeHeaderLogoImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.homePageHeaderLogo.altText"}" />
<br />
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="homeHeaderLogoImageAltText" key="common.altText"}</td>
		<td width="80%" class="value"><input type="text" id="homeHeaderLogoImageAltText" name="homeHeaderLogoImageAltText[{$formLocale|escape}]" value="{$homeHeaderLogoImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td>&nbsp;</td>
		<td class="value"><span class="instruct">{translate key="common.altTextInstructions"}</span></td>
		</tr>
</table>
{/if}
</div>
</div>
<div class="separator"></div>
<div id="conferencePageHeaderInfo">
<h3>3.2 {translate key="manager.setup.layout.conferencePageHeader"}</h3>

<button type="button" class="btn btn-default btn-sm" onclick="$(this).next().show();$(this).hide();">
    {translate key="common.more"}
</button>
<div style="display:none;">
<p>{translate key="manager.setup.layout.conferencePageHeader.description"}</p>
<div id="conferenceTitle">
<h4>{translate key="manager.setup.layout.conferenceTitle"}</h4>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label"><input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-0" value="0"{if not $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-0" key="manager.setup.layout.useTextTitle"}</td>
		<td width="80%" class="value"><input type="text" name="pageHeaderTitle[{$formLocale|escape}]" value="{$pageHeaderTitle[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td width="20%" class="label"><input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-1" value="1"{if $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-1" key="manager.setup.layout.useImageTitle"}</td>
		<td width="80%" class="value"><input type="file" name="pageHeaderTitleImage" class="uploadField" /> <input type="submit" name="uploadPageHeaderTitleImage" value="{translate key="common.upload"}" class="button" /></td>
	</tr>
</table>

{if $pageHeaderTitleImage[$formLocale]}
{translate key="common.fileName"}: {$pageHeaderTitleImage[$formLocale].name|escape} {$pageHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deletePageHeaderTitleImage" value="{translate key="common.delete"}" class="button" />
<br />
<img src="{$publicFilesDir}/{$pageHeaderTitleImage[$formLocale].uploadName|escape}" width="{$pageHeaderTitleImage[$formLocale].width|escape}" height="{$pageHeaderTitleImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.pageHeader.altText"}" />
<br />
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="pageHeaderTitleImageAltText" key="common.altText"}</td>
		<td width="80%" class="value"><input type="text" id="pageHeaderTitleImageAltText" name="pageHeaderTitleImageAltText[{$formLocale|escape}]" value="{$pageHeaderTitleImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td>&nbsp;</td>
		<td class="value"><span class="instruct">{translate key="common.altTextInstructions"}</span></td>
		</tr>
</table>
{/if}
</div>
<div id="conferenceLogo">
<h4>{translate key="manager.setup.layout.conferenceLogo"}</h4>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="manager.setup.layout.useImageLogo"}</td>
		<td width="80%" class="value"><input type="file" name="pageHeaderLogoImage" class="uploadField" /> <input type="submit" name="uploadPageHeaderLogoImage" value="{translate key="common.upload"}" class="button" /></td>
	</tr>
</table>

{if $pageHeaderLogoImage[$formLocale]}
{translate key="common.fileName"}: {$pageHeaderLogoImage[$formLocale].name|escape} {$pageHeaderLogoImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deletePageHeaderLogoImage" value="{translate key="common.delete"}" class="button" />
<br />
<img src="{$publicFilesDir}/{$pageHeaderLogoImage[$formLocale].uploadName|escape}" width="{$pageHeaderLogoImage[$formLocale].width|escape}" height="{$pageHeaderLogoImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.pageHeaderLogo.altText"}" />
<br />
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="pageHeaderLogoImageAltText" key="common.altText"}</td>
		<td width="80%" class="value"><input type="text" id="pageHeaderLogoImageAltText" name="pageHeaderLogoImageAltText[{$formLocale|escape}]" value="{$pageHeaderLogoImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td>&nbsp;</td>
		<td class="value"><span class="instruct">{translate key="common.altTextInstructions"}</span></td>
		</tr>
</table>
{/if}
</div>
</div>
<div id="conferenceFavicon">
<h4>{translate key="manager.setup.layout.favicon"}</h4>

<p>{translate key="manager.setup.layout.faviconDescription"}</p>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="manager.setup.layout.useImageLogo"}</td>
		<td width="80%" class="value"><input type="file" name="conferenceFavicon" class="uploadField" /> <input type="submit" name="uploadConferenceFavicon" value="{translate key="common.upload"}" class="button" /></td>
	</tr>
</table>

{if $conferenceFavicon[$formLocale]}
{translate key="common.fileName"}: {$conferenceFavicon[$formLocale].name|escape} {$conferenceFavicon[$formLocale].dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteConferenceFavicon" value="{translate key="common.delete"}" class="button" />
<br />
<img src="{$publicFilesDir}/{$conferenceFavicon[$formLocale].uploadName|escape:"url"}" width="16px" height="16px" style="border: 0;" alt="favicon" />
{/if}
</div>

<div id="alternateHeader">
<h4>{translate key="manager.setup.layout.alternateHeader"}</h4>

<p>{translate key="manager.setup.layout.alternateHeaderDescription"}</p>

<p><textarea name="conferencePageHeader[{$formLocale|escape}]" id="conferencePageHeader" rows="10" cols="60" class="textArea">{$conferencePageHeader[$formLocale]|escape}</textarea></p>
</div>
</div>

<div class="separator"></div>

<div id="conferencePageFooterInfo">
<h3>3.3 {translate key="manager.setup.layout.conferencePageFooter"}</h3>

<p>{translate key="manager.setup.layout.conferencePageFooterDescription"}</p>

<p><textarea name="conferencePageFooter[{$formLocale|escape}]" id="conferencePageFooter" rows="10" cols="60" class="textArea">{$conferencePageFooter[$formLocale]|escape}</textarea></p>
</div>

<div class="separator"></div>
<div id="navigationBar">
<h3>3.4 {translate key="manager.setup.layout.navigationBar"}</h3>

<p>{translate key="manager.setup.layout.itemsDescription"}</p>
<script type="text/javascript">
{literal}
var _linkTypeChange = function (_select) {
    _select = $(_select);
    var _survey_config = _select.parents("tr:first").nextAll(".survey-config");
    var _nav_page = _select.parents("tr:first").nextAll(".nav-page");
    var _url = _select.parents("tr:first").nextAll(".url");
    if (_select.val() === "4") {
        _survey_config.show();
        _nav_page.hide();
        _url.hide();
    }
    if (_select.val() === "5") {
        _survey_config.hide();
        _nav_page.show();
        _url.hide();
    }
    else {
        _survey_config.hide();
        _nav_page.hide();
        _url.show();
    }
};
{/literal}
</script>
<table width="100%" class="data">
	{foreach name=navItems from=$navItems[$formLocale] key=navItemId item=navItem}
		<tr valign="top" {if $smarty.foreach.navItems.last} id="navItems-last" {/if}>
			<td width="20%" class="label">{fieldLabel name="navItems-$navItemId-name" key="manager.setup.layout.labelName"}</td>
			<td width="80%" class="value">
				<input type="text" name="navItems[{$formLocale|escape}][{$navItemId}][name]" id="navItems-{$navItemId}-name" value="{$navItem.name|escape}" size="30" maxlength="90" class="textField" /> <input type="submit" name="delNavItem[{$navItemId}]" value="{translate key="common.delete"}" class="button" />
				<table width="100%">
					<tr valign="top">
						<td width="5%"><input type="checkbox" name="navItems[{$formLocale|escape}][{$navItemId}][isLiteral]" id="navItems-{$navItemId}-isLiteral" value="1"{if $navItem.isLiteral !== FALSE} checked="checked"{/if} /></td>
						<td width="95%">{fieldLabel name="navItems-$navItemId-isLiteral" key="manager.setup.layout.navItemIsLiteral"}</td>
					</tr>
				</table>
                                <table width="100%">
                                        <tr valign="top">
                                                <th>
                                                   {fieldLabel name="navItems-$navItemId-url" key="manager.setup.layout.visibility"} 
                                                </th>
						<td>
                                                    <select name="navItems[{$formLocale|escape}][{$navItemId}][visibility]" id="navItems[{$formLocale|escape}][{$navItemId}][visibility]" class="selectMenu">
                                                        <option value="1" {if $navItem.visibility == '1'}selected{/if}>{translate key="manager.setup.layout.visibility.1"}</option>
                                                        <option value="2" {if $navItem.visibility == '2'}selected{/if}>{translate key="manager.setup.layout.visibility.2"}</option>
                                                        <option value="3" {if $navItem.visibility == '3'}selected{/if}>{translate key="manager.setup.layout.visibility.3"}</option>
                                                        <option value="4" {if $navItem.visibility == '4'}selected{/if}>{translate key="manager.setup.layout.visibility.4"}</option>
                                                        <option value="0" {if $navItem.visibility == '0'}selected{/if}>{translate key="manager.setup.layout.visibility.0"}</option>
                                                    </select>
                                                </td>
					</tr>
                                        <tr valign="top">
                                                <th>
                                                   {fieldLabel name="navItems-$navItemId-order" key="common.order"} 
                                                </th>
						<td>
                                                    <input type="number" name="navItems[{$formLocale|escape}][{$navItemId}][order]" id="navItems-{$navItemId}-order" value="{$navItem.order|escape}" class="textField" />
                                                    * 數字越小，排在越上面 {* @TODO 語系 *}
                                                </td>
					</tr>
                                        <tr valign="top">
                                                <th>
                                                   {fieldLabel name="navItems-$navItemId-navOrder" key="上方導覽列排序"} {* @TODO 語系 *} 
                                                </th>
						<td>
                                                    <input type="number" name="navItems[{$formLocale|escape}][{$navItemId}][navOrder]" id="navItems-{$navItemId}-navOrder" value="{$navItem.navOrder|escape}" class="textField" />
                                                    * 數字越小，排在越上面，空白或0表示不顯示 {* @TODO 語系 *}
                                                </td>
					</tr>
                                        <tr valign="top">
                                                <th>
                                                   {fieldLabel name="navItems-$navItemId-url" key="manager.setup.layout.linkType"} 
                                                </th>
						<td>
                                                    <select name="navItems[{$formLocale|escape}][{$navItemId}][urlType]" id="navItems[{$formLocale|escape}][{$navItemId}][urlType]" onchange="_linkTypeChange(this);" class="selectMenu">
                                                        <option value="1" {if $navItem.urlType == '1'}selected{/if}>{translate key="manager.setup.layout.linkType.1"}</option>
                                                        <option value="2" {if $navItem.urlType == '2'}selected{/if}>{translate key="manager.setup.layout.linkType.2"}</option>
                                                        <option value="3" {if $navItem.urlType == '3'}selected{/if}>{translate key="manager.setup.layout.linkType.3"}</option>
                                                        <option value="4" {if $navItem.urlType == '4'}selected{/if}>{translate key="manager.setup.layout.linkType.4"}</option>
                                                        <option value="5" {if $navItem.urlType == '5'}selected{/if}>{translate key="manager.setup.layout.linkType.5"}</option>
                                                    </select>
                                                </td>
					</tr>
					<tr valign="top" class="url" {if $navItem.urlType == '4' OR $navItem.urlType == '5'}style="display:none;"{/if}>
						<th>
                                                   {fieldLabel name="navItems-$navItemId-url" key="common.url"} 
                                                </th>
						<td>
                                                    <input type="text" name="navItems[{$formLocale|escape}][{$navItemId}][url]" id="navItems-{$navItemId}-url" value="{$navItem.url|escape}" size="60" maxlength="255" class="textField" />
                                                </td>
                                        </tr>
                                        <tr valign="top" class="survey-config" {if $navItem.urlType != '4'}style="display:none;"{/if}>
                                                <th>
                                                   {fieldLabel name="navItems-$navItemId-survey" key="manager.setup.layout.surveyConfig"} 
                                                </th>
                                                <td>
                                                    <textarea name="navItems[{$formLocale|escape}][{$navItemId}][survey]" id="navItems-{$navItemId}-survey" rows="10" cols="60" class="textArea">{$navItem.survey}</textarea>
                                                </td>
                                        </tr>
                                        <tr valign="top" class="survey-config" {if $navItem.urlType != '4'}style="display:none;"{/if}>
                                                <th>
                                                    {fieldLabel name="navItems-$navItemId-survey" key="common.export"} 
                                                </th>
                                                <td>
                                                    <a href="{url page="schedConf" op="surveyExport"}?id={$navItemId}" class="btn btn-default">
                                                        {translate key="manager.setup.layout.surveyExport"}
                                                    </a>
                                                </td>
                                        </tr>
                                        <tr valign="top" class="nav-page" {if $navItem.urlType != '5'}style="display:none;"{/if}>
						<th>
                                                   {fieldLabel name="navItems-$navItemId-navPage" key="common.page"} 
                                                </th>
						<td>
                                                    <textarea class="nagPageTextarea" name="navItems[{$formLocale|escape}][{$navItemId}][navPage]" id="navItems-{$navItemId}-navPage" rows="10" cols="60" class="textArea">{$navItem.navPage}</textarea>
                                                </td>
                                        </tr>
                                    </table> 
                                                
                                    <table width="100%" class="hidden">
					<tr valign="top">
						<td width="5%">
                                                    <input type="checkbox" name="navItems[{$formLocale|escape}][{$navItemId}][isAbsolute]" id="navItems-{$navItemId}-isAbsolute" value="1"{if $navItem.isAbsolute} checked="checked"{/if} />
                                                </td>
						<td width="95%">
                                                    {fieldLabel name="navItems-$navItemId-isAbsolute" key="manager.setup.layout.navItemIsAbsolute"}</label>
                                                </td>
					</tr>
				</table>
			</td>
		</tr>
		{if !$smarty.foreach.navItems.last}
			<tr valign="top">
				<td colspan="2" class="separator">&nbsp;</td>
			</tr>
		{/if}
	{foreachelse}
                {* 只有一行！ *}
		<tr valign="top" id="navItems-last">
			<td width="20%" class="label">{fieldLabel name="navItems-0-name" key="manager.setup.layout.labelName"}</td>
			<td width="80%" class="value">
				<input type="text" name="navItems[{$formLocale|escape}][0][name]" id="navItems-0-name" size="30" maxlength="90" class="textField" />
				<table width="100%">
					<tr valign="top">
						<td width="5%"><input type="checkbox" name="navItems[{$formLocale|escape}][0][isLiteral]" id="navItems-0-isLiteral" value="1" /></td>
						<td width="95%">{fieldLabel name="navItems-0-isLiteral" key="manager.setup.layout.navItemIsLiteral"}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr valign="top">
			<td width="20%" class="label">{fieldLabel name="navItems-0-url" key="common.url"}</td>
			<td width="80%" class="value">
				<input type="text" name="navItems[{$formLocale|escape}][0][url]" id="navItems-0-url" size="60" maxlength="255" class="textField" />
                                <label>
                                    {translate key="manager.setup.layout.visibility"}
                                    <select name="navItems[{$formLocale|escape}][{$navItemId}][visibility]" id="navItems[{$formLocale|escape}][{$navItemId}][visibility]" class="selectMenu">
                                        <option value="1" {if $navItem.urlType == 1}selected{/if}>{translate key="manager.setup.layout.visibility.1"}</option>
                                        <option value="2" {if $navItem.urlType == 2}selected{/if}>{translate key="manager.setup.layout.visibility.2"}</option>
                                        <option value="3" {if $navItem.urlType == 3}selected{/if}>{translate key="manager.setup.layout.visibility.3"}</option>
                                        <option value="4" {if $navItem.urlType == 4}selected{/if}>{translate key="manager.setup.layout.visibility.4"}</option>
                                    </select>
                                </label>
                                <label>
                                    {translate key="manager.setup.layout.linkType"}
                                    <select name="navItems[{$formLocale|escape}][{$navItemId}][urlType]" id="navItems[{$formLocale|escape}][{$navItemId}][urlType]" class="selectMenu">
                                        <option value="1" {if $navItem.urlType == 1}selected{/if}>{translate key="manager.setup.layout.linkType.1"}</option>
                                        <option value="2" {if $navItem.urlType == 2}selected{/if}>{translate key="manager.setup.layout.linkType.2"}</option>
                                        <option value="3" {if $navItem.urlType == 3}selected{/if}>{translate key="manager.setup.layout.linkType.3"}</option>
                                    </select>
                                </label>
                                
				<table width="100%" class="hidden">
					<tr valign="top">
						<td width="5%"><input type="checkbox" name="[{$formLocale|escape}]navItems[0][isAbsolute]" id="navItems-0-isAbsolute" value="1" /></td>
						<td width="95%">{fieldLabel name="navItems-0-isAbsolute" key="manager.setup.layout.navItemIsAbsolute"}</td>
					</tr>
				</table>
			</td>
		</tr>
	{/foreach}
</table>

<p><input type="submit" name="addNavItem" id="addNavItem" value="{translate key="manager.setup.layout.addNavItem"}" class="button" /></p>
</div>
<div class="separator"></div>

<div id="lists">
<h3>3.5 {translate key="manager.setup.layout.lists"}</h3>

<p>{translate key="manager.setup.layout.lists.description"}</p>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{translate key="manager.setup.layout.itemsPerPage"}</td>
		<td width="80%" class="value"><input type="text" size="3" name="itemsPerPage" class="textField" value="{$itemsPerPage|escape}" /></td>
	</tr>
	<tr valign="top">
		<td width="20%" class="label">{translate key="manager.setup.layout.numPageLinks"}</td>
		<td width="80%" class="value"><input type="text" size="3" name="numPageLinks" class="textField" value="{$numPageLinks|escape}" /></td>
	</tr>
</table>
</div>
<div class="separator"></div>

<!-------------------------------------------------->


<div id="googleAnalytics">
<h3>
    3.6 {translate key="manager.setup.googleAnalytics"}
</h3>

<p>{translate key="manager.setup.googleAnalytics.description"}</p>

<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">
                    {translate key="manager.setup.googleAnalytics.analyticsTrackingID"}
                </td>
		<td width="80%" class="value">
                    <input type="text" size="20" name="analyticsTrackingID" class="textField" value="{$analyticsTrackingID|escape}" />
                    <a href="https://www.google.com/analytics/web/" target="_blank">
                        {translate key="manager.setup.googleAnalytics.open"}
                    </a>
                    <br />
                    <a href="https://www.youtube.com/watch?v=lCz40QHo0-0" target="_blank">
                        {translate key="manager.setup.googleAnalytics.help"}
                    </a>
                </td>
	</tr>
</table>
</div>
<div class="separator"></div>

<p class="text-center">
    <input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-primary" /> 
    <input type="button" value="{translate key="common.cancel"}" class="btn btn-default" onclick="document.location.href='{url op="setup"}'" />
</p>



</form>

{include file="common/footer.tpl"}
