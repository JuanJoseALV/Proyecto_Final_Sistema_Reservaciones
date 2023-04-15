<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Mis_Reservaciones"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server" >
     
    <div class="container " style="margin-top: 10%; margin-right: auto; margin-bottom: auto; margin-left: 30%;">
        <div>
            <label id="LBL_Login" runat="server" Font-Size="X-Large">Login</label>
        </div>
        <div class="mb-3">
            <asp:Label ID="Label1" runat="server" CssClass="alert-danger" Visible="false">Correo o contraseña invalidos</asp:Label>
        </div>
        <div class="mb-3">
            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Ingrese un correo electrónico válido" ControlToValidate="Txt_Email" CssClass="alert-warning" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
        </div>
        <div class="mb-3">
            <asp:Label ID="Lbl_Email" runat="server" CssClass="c">Email</asp:Label>
            <asp:TextBox ID="Txt_Email" runat="server" CssClass="form-control" ></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Este campo debe de ser obligatorio" CssClass="alert-danger" ControlToValidate="Txt_Email"></asp:RequiredFieldValidator>
        </div>
        <div class="mb-3">
            <asp:Label ID="Lbl_Contraseña" runat="server" CssClass="form-label">Contraseña</asp:Label>
            <asp:TextBox ID="Txt_Contraseña" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Este campo debe de ser obligatorio" CssClass="alert-danger" ControlToValidate="Txt_Contraseña"></asp:RequiredFieldValidator>
        </div>
        <div class="mb-3" style="margin-top:2%">
            <asp:Button ID="Btn_Sesion" runat="server" CssClass="btn-primary" Text="Inicar sesion" OnClick="Btn_Sesion_Click" />
            <asp:Button ID="Btn_Cancelar" runat="server" CssClass="btn-danger" Text="Cancelar" />
        </div>
    </div>
      <style type="text/css">
        #<%= LBL_Login.ClientID %> {
            color: aqua;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
            font-size:xx-large;
        }
        #<%= Lbl_Email.ClientID %>{
            color:aqua;
            font-size:large;
        }
        #<%= Lbl_Contraseña.ClientID %>{
            color:aqua;
            font-size:large;
        }
        #<%=Btn_Sesion.ClientID%>{
            background-color:blue;
            border-radius: 12px;
        }
        #<%=Btn_Sesion.ClientID%>:hover{
            background-color:cyan;
        }
        #<%=Btn_Cancelar.ClientID%>{
            background-color:maroon; 
            border-radius: 12px;
        }
        #<%=Btn_Cancelar.ClientID%>:hover{
            background-color:red;   
        }
    </style>
</asp:Content>
