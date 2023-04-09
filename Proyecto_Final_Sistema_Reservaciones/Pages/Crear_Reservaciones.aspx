<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Crear_Reservaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Crear_Reservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top:5%">
        <div>
            <asp:Label Text="Crear reservacion" runat="server" Font-Size="X-Large" ForeColor="Blue" />
        </div>
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Hotel"></asp:Label>
            <br />
            <asp:DropDownList ID="DL_Hotel" runat="server" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
           <asp:Label ID="LBl_Validacion_Ho" runat="server" Text="Debe de seleccionar un Hotel valido" CssClass="alert-warning" Visible="False"></asp:Label>
        </div>
        <div class="form-group">
            <asp:Label ID="Label10" runat="server" Text="Cliente"></asp:Label>
            <br />
            <asp:DropDownList ID="DL_Cliente" runat="server" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
            <asp:Label ID="LBl_Validacion_Usu" runat="server" Text="Debe de seleccionar un usuario valido" CssClass="alert-warning" Visible="False"></asp:Label>
        </div>
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" Text="Fecha de entrada" Width="180px"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="Fecha de salida"></asp:Label>
            <br />
            <input id="INP_Fecha_En" type="text"  placeholder="dd/MM/yyyy" runat="server" formmethod="get" />
            <input id="INP_Fecha_Sal" type="text" placeholder="dd/MM/yyyy" runat="server"/>
            <br />
            <asp:CustomValidator ID="CV_Fecha_En" runat="server" ControlToValidate="INP_Fecha_En"  CssClass="alert-warning" OnServerValidate="CV_Fecha_En_ServerValidate" ></asp:CustomValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Fecha entrada requerida" ControlToValidate="INP_Fecha_En" CssClass="alert-danger"></asp:RequiredFieldValidator>
            <br />
            <asp:CustomValidator ID="CV_Fecha_Sal" runat="server" ControlToValidate="INP_Fecha_Sal" CssClass="alert-warning" OnServerValidate="CV_Fecha_Sal_ServerValidate"></asp:CustomValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Fecha salida requerida" ControlToValidate="INP_Fecha_Sal" CssClass="alert-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Label ID="Label6" runat="server" Text="Numero de adultos" Width="180px"></asp:Label>
            <asp:Label ID="Label7" runat="server" Text="Numero de niños"></asp:Label>
            <br />
             <input id="INP_Num_A" type="number" runat="server"/>
            <input id="INP_Num_N" type="number" runat="server"/>

        </div>
        <div class="form-group">
            <asp:Button ID="BTN_Guardar" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="BTN_Guardar_Click" />
            <asp:Button ID="BTN_Regresar" runat="server" Text="Regresar" CssClass="btn-success"  />
        </div>
    </div>
</asp:Content>
