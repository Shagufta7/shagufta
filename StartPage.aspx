<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StartPage.aspx.cs" Inherits="StartPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        
        <br />
        <br /><center>
             <asp:TextBox id="txtusername" runat="server" Height="37px" Width="179px"></asp:TextBox> <br />
    <asp:TextBox id="password" runat="server" Height="37px" Width="179px"></asp:TextBox> <br />
            <br />
            <br />

    <asp:Button ID="Login" runat="server" text="Login" OnClick="Login_Click" Height="37px" Width="179px" />
        </center>
        

    </form>
</body>
</html>
