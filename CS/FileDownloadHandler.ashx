<%@ WebHandler Language="C#" Class="FileDownloadHandler" %>

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;

public class FileDownloadHandler : IHttpHandler
{
    private string dbPath = "~/App_Data/SampleDB.mdb";

    public void ProcessRequest(HttpContext context)
    {
        string id = context.Request["id"];
        byte[] fileBytes = GetFileBytesByKey(context, id);

        if (fileBytes != null)
            ExportToResponse(context, fileBytes, "file_" + id, "pdf", false);
        else
            context.Response.Redirect("~/Default.aspx");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    private byte[] GetFileBytesByKey(HttpContext context, object key)
    {
        int value;
        if (key == null || !Int32.TryParse(key.ToString(), out value)) return null;
        SqlDataSource ds = new SqlDataSource();

        ds.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        ds.ProviderName = ConfigurationManager.ConnectionStrings["ConnectionString"].ProviderName;
        ds.SelectCommand = "SELECT [File] FROM [Sample] WHERE [ID] = " + key.ToString();

        DataTable dt = ((DataView)ds.Select(DataSourceSelectArguments.Empty)).Table;
        byte[] file = null;
        if (dt.Rows.Count > 0)
        {
            file = dt.Rows[0]["File"] as byte[];
        }
        return file;
    }

    public void ExportToResponse(HttpContext context, byte[] content, string fileName, string fileType, bool inline)
    {
        context.Response.Clear();
        context.Response.ContentType = "application/" + fileType;
        context.Response.AddHeader("Content-Disposition", string.Format("{0}; filename={1}.{2}", inline ? "Inline" : "Attachment",
            fileName, fileType));
        context.Response.AddHeader("Content-Length", content.Length.ToString());
        context.Response.BinaryWrite(content);
        context.Response.Flush();
        context.Response.Close();
        context.Response.End();
    }

}