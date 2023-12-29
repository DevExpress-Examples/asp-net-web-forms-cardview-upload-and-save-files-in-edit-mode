<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128530329/16.2.3%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T578527)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->

# CardView for ASP.NET Web Forms - How to upload files in edit mode and save them to a database

This example demonstrates how to upload and save files in edit mode.

## Overview

Follow the steps below:

1. Specify the control's [EditItemTemplate](https://docs.devexpress.com/AspNet/DevExpress.Web.CardViewColumn.EditItemTemplate) property and add an [upload control](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxUploadControl) to the template.
2. In the [FileUploadComplete](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxUploadControl.FileUploadComplete) event handler, save files to a session.
3. When the user saves changes, save the uploaded files to a database in the [CardUpdating](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxCardView.CardUpdating) event handler.
4. To allow the user to download files, use a hyper link control and add it to the grid's data item template.
5. In the hyperlink's `Load` event handler, specify the control's `Text` and `NavigateUrl` properties. <a href="https://www.devexpress.com/Support/Center/Question/Details/K18282/the-general-technique-of-using-the-init-load-event-handler">The general technique of using the Init/Load event handler</a> topic.</p>

## Files to Review

* [CustomException.cs](./CS/App_Code/CustomException.cs) (VB: [CustomException.vb](./VB/App_Code/CustomException.vb))
* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/Default.aspx.vb))
* [FileDownloadHandler.ashx](./CS/FileDownloadHandler.ashx) (VB: [FileDownloadHandler.ashx](./VB/FileDownloadHandler.ashx))

## Documentation

* [Access Controls in Templates on the Server](https://docs.devexpress.com/AspNet/403575/common-concepts/access-controls-in-templates-on-the-server)
