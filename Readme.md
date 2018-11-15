<!-- default file list -->
*Files to look at*:

* [CustomException.cs](./CS/App_Code/CustomException.cs) (VB: [CustomException.vb](./VB/App_Code/CustomException.vb))
* **[Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))**
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx](./VB/Default.aspx))
* [FileDownloadHandler.ashx](./CS/FileDownloadHandler.ashx) (VB: [FileDownloadHandler.ashx](./VB/FileDownloadHandler.ashx))
<!-- default file list end -->
# ASPxCardView - How to upload files in the Edit mode and save them in a database


<p>This example demonstrates how to upload and save files in the Edit mode.<br><a href="https://documentation.devexpress.com/AspNet/4040/ASP-NET-WebForms-Controls/File-Management/File-Upload/Overview/ASPxUploadControl-Overview">ASPxUploadControl</a> in <strong>EditItemTemplate</strong> is used to upload files. A file is saved to a session in the <a href="https://documentation.devexpress.com/AspNet/DevExpress.Web.ASPxUploadControl.FileUploadComplete.event">ASPxUploadControl.FileUploadComplete</a> event handler.</p>
<p>Then the uploaded file is saved to a database in the <a href="https://documentation.devexpress.com/AspNet/DevExpress.Web.ASPxCardView.CardUpdating.event">ASPxCardView.CardUpdating</a> event handler when the user saves changes.<br>To provide the user with a capability to download files the <a href="https://documentation.devexpress.com/AspNet/11537/ASP-NET-WebForms-Controls/Data-Editors/Editor-Types/ASPxHyperLink/Overview/ASPxHyperLink-Overview">ASPxHyperLink</a> control is used in <strong>DataItemTemplate</strong>. The <a href="https://documentation.devexpress.com/AspNet/DevExpress.Web.ASPxHyperLink.Text.property">ASPxHyperLink.Text</a> and <a href="https://documentation.devexpress.com/AspNet/DevExpress.Web.ASPxHyperLink.NavigateUrl.property">ASPxHyperLink.NavigateUrl</a> properties are set in the <strong>ASPxHyperLink.Load</strong> event handler using the technique described in the <a href="https://www.devexpress.com/Support/Center/Question/Details/K18282/the-general-technique-of-using-the-init-load-event-handler">The general technique of using the Init/Load event handler</a> topic.</p>

<br/>


