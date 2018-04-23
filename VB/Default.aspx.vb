Imports DevExpress.Web
Imports System
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Partial Public Class _Default
	Inherits System.Web.UI.Page

	Private Const SessionKey As String = "UploadedFile"
	Private fileColumn As String = "File"
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If Not IsPostBack Then
			Session.Clear()
		End If
	End Sub

	Protected Sub HyperLink_Init(ByVal sender As Object, ByVal e As EventArgs)
		Dim hyperLink As ASPxHyperLink = TryCast(sender, ASPxHyperLink)
		Dim container As CardViewDataItemTemplateContainer = TryCast(hyperLink.NamingContainer, CardViewDataItemTemplateContainer)
		Dim fileBytes() As Byte = TryCast(CardView.GetCardValues(container.VisibleIndex, fileColumn), Byte())
		If fileBytes IsNot Nothing Then
			hyperLink.NavigateUrl = String.Format("FileDownloadHandler.ashx?id={0}", container.KeyValue)
			hyperLink.Text = "file.pdf"
		End If
	End Sub

	Protected Sub UploadControl_FileUploadComplete(ByVal sender As Object, ByVal e As DevExpress.Web.FileUploadCompleteEventArgs)
		If e.IsValid Then
			Session(SessionKey) = e.UploadedFile.FileBytes
			e.CallbackData = e.UploadedFile.FileName
		End If
	End Sub

	Protected Sub Callback_Callback(ByVal source As Object, ByVal e As DevExpress.Web.CallbackEventArgs)
		Session.Remove(SessionKey)
		e.Result = "OK"
	End Sub

	Protected Sub CardView_CardUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
		If Session(SessionKey) IsNot Nothing Then
			e.NewValues(fileColumn) = Session(SessionKey)
		End If
		Session.Remove(SessionKey)
		Throw New CustomException("Data updates aren't allowed in online examples")
	End Sub

	Protected Sub CardView_CustomErrorText(ByVal sender As Object, ByVal e As ASPxCardViewCustomErrorTextEventArgs)
		If TypeOf e.Exception Is CustomException Then
			e.ErrorText = e.Exception.Message
		End If
	End Sub
End Class