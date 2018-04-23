<%@ WebHandler Language="vb" Class="FileDownloadHandler" %>

Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.Data

Public Class FileDownloadHandler
	Implements IHttpHandler

	Private dbPath As String = "~/App_Data/SampleDB.mdb"

	Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		Dim id As String = context.Request("id")
		Dim fileBytes() As Byte = GetFileBytesByKey(context, id)

		If fileBytes IsNot Nothing Then
			ExportToResponse(context, fileBytes, "file_" & id, "pdf", False)
		Else
			context.Response.Redirect("~/Default.aspx")
		End If
	End Sub

	Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property

	Private Function GetFileBytesByKey(ByVal context As HttpContext, ByVal key As Object) As Byte()
		Dim value As Integer = Nothing
		If key Is Nothing OrElse Not Int32.TryParse(key.ToString(), value) Then
			Return Nothing
		End If
		Dim ds As New SqlDataSource()

		ds.ConnectionString = ConfigurationManager.ConnectionStrings("ConnectionString").ConnectionString
		ds.ProviderName = ConfigurationManager.ConnectionStrings("ConnectionString").ProviderName
		ds.SelectCommand = "SELECT [File] FROM [Sample] WHERE [ID] = " & key.ToString()

		Dim dt As DataTable = DirectCast(ds.Select(DataSourceSelectArguments.Empty), DataView).Table
		Dim file() As Byte = Nothing
		If dt.Rows.Count > 0 Then
			file = TryCast(dt.Rows(0)("File"), Byte())
		End If
		Return file
	End Function

	Public Sub ExportToResponse(ByVal context As HttpContext, ByVal content() As Byte, ByVal fileName As String, ByVal fileType As String, ByVal inline As Boolean)
		context.Response.Clear()
		context.Response.ContentType = "application/" & fileType
		context.Response.AddHeader("Content-Disposition", String.Format("{0}; filename={1}.{2}",If(inline, "Inline", "Attachment"), fileName, fileType))
		context.Response.AddHeader("Content-Length", content.Length.ToString())
		context.Response.BinaryWrite(content)
		context.Response.Flush()
		context.Response.Close()
		context.Response.End()
	End Sub

End Class