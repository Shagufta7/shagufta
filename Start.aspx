<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" %>

<script runat="server">

   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:TextBox id="username" runat="server"></asp:TextBox> <br />
    <asp:TextBox id="password" runat="server"></asp:TextBox> <br />
    <asp:Button ID="Login" runat="server"  />
</asp:Content>

