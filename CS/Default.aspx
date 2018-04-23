<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function onFileUploadComplete(s, e) {
            if (e.callbackData != "") {
                fileNameLabel.SetText(e.callbackData);
                deleteFileButton.SetVisible(true);
            }
        }

        function onClick(s, e) {
            callback.PerformCallback(fileNameLabel.GetText());
        }

        function onCallbackComplete(s, e) {
            if (e.result == "OK") {
                fileNameLabel.SetText(null);
                deleteFileButton.SetVisible(false);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <dx:ASPxCardView ID="CardView" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" 
            OnCardUpdating="CardView_CardUpdating" OnCustomErrorText="CardView_CustomErrorText">
            <Columns>
                <dx:CardViewTextColumn FieldName="ID" ReadOnly="True" Visible="False">
                </dx:CardViewTextColumn>
                <dx:CardViewTextColumn FieldName="SomeColumn" VisibleIndex="0">
                </dx:CardViewTextColumn>
                <dx:CardViewTextColumn FieldName="File" VisibleIndex="1">
                    <DataItemTemplate>
                        <dx:ASPxHyperLink ID="HyperLink" runat="server" Text="No data uploaded" OnInit="HyperLink_Init"></dx:ASPxHyperLink>
                    </DataItemTemplate>
                    <EditItemTemplate>
                        <dx:ASPxLabel ID="AllowedTypesLabel" runat="server" Text="Allowed file types: .pdf" Font-Size="Smaller" />
                            <br />
                            <dx:ASPxLabel ID="MaxFileSizeLabel" runat="server" Text="Maximum file size: 4Mb" Font-Size="Smaller" />
                            <br />
                            <dx:ASPxUploadControl ID="UploadControl" runat="server" ShowProgressPanel="true" UploadMode="Auto" 
                                AutoStartUpload="true" OnFileUploadComplete="UploadControl_FileUploadComplete">
                                <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".pdf" />
                                <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                            </dx:ASPxUploadControl>
                            <br />
                            <dx:ASPxLabel ID="FileNameLabel" ClientInstanceName="fileNameLabel" runat="server" Font-Size="Smaller"></dx:ASPxLabel>
                            <dx:ASPxButton ID="DeleteFileButton" ClientInstanceName="deleteFileButton" runat="server" AutoPostBack="false" 
                                RenderMode="Link" ClientVisible="false" Text="Delete">
                                <ClientSideEvents Click="onClick" />
                            </dx:ASPxButton>
                    </EditItemTemplate>
                </dx:CardViewTextColumn>
            </Columns>
            <CardLayoutProperties>
                <Items>
                    <dx:CardViewCommandLayoutItem HorizontalAlign="Right" ShowEditButton="True">
                    </dx:CardViewCommandLayoutItem>
                    <dx:CardViewColumnLayoutItem ColumnName="SomeColumn">
                    </dx:CardViewColumnLayoutItem>
                    <dx:CardViewColumnLayoutItem ColumnName="File">
                    </dx:CardViewColumnLayoutItem>
                    <dx:EditModeCommandLayoutItem HorizontalAlign="Right">
                    </dx:EditModeCommandLayoutItem>
                </Items>
            </CardLayoutProperties>
        </dx:ASPxCardView>
        <dx:ASPxCallback ID="Callback" ClientInstanceName="callback" runat="server" OnCallback="Callback_Callback">
            <ClientSideEvents CallbackComplete="onCallbackComplete" />
        </dx:ASPxCallback>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [Sample]"
            UpdateCommand="UPDATE Sample SET SomeColumn = ?, File = ? WHERE ID = ?">
            <UpdateParameters>
                <asp:FormParameter Name="SomeColumn" FormField="SomeColumn" Type="String" />
                <asp:Parameter Name="File" DbType="Binary" />
                <asp:FormParameter Name="ID" FormField="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
