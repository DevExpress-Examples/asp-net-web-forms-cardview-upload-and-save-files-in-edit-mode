using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    private const string SessionKey = "UploadedFile";
    private string fileColumn = "File";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Session.Clear();
    }

    protected void HyperLink_Init(object sender, EventArgs e)
    {
        ASPxHyperLink hyperLink = sender as ASPxHyperLink;
        CardViewDataItemTemplateContainer container = hyperLink.NamingContainer as CardViewDataItemTemplateContainer;
        byte[] fileBytes = CardView.GetCardValues(container.VisibleIndex, fileColumn) as byte[];
        if (fileBytes != null)
        {
            hyperLink.NavigateUrl = string.Format("FileDownloadHandler.ashx?id={0}", container.KeyValue);
            hyperLink.Text = "file.pdf";
        }
    }

    protected void UploadControl_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
    {
        if (e.IsValid)
        {
            Session[SessionKey] = e.UploadedFile.FileBytes;
            e.CallbackData = e.UploadedFile.FileName;
        }
    }

    protected void Callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
    {
        Session.Remove(SessionKey);
        e.Result = "OK";
    }

    protected void CardView_CardUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
    {
        if (Session[SessionKey] != null)
            e.NewValues[fileColumn] = Session[SessionKey];
        Session.Remove(SessionKey);
        throw new CustomException("Data updates aren't allowed in online examples");
    }

    protected void CardView_CustomErrorText(object sender, ASPxCardViewCustomErrorTextEventArgs e)
    {
        if (e.Exception is CustomException)
            e.ErrorText = e.Exception.Message;
    }
}