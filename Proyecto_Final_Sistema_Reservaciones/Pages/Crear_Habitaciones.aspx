<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Crear_Habitaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Crear_Habitaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top: 5%">
        <div>
            <asp:Label Text="Crear habitacion" runat="server" ID="LBL_Crear" />
        </div>
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Hotel"></asp:Label>
            <br />
            <asp:DropDownList ID="DL_Hotel" runat="server" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
            <br />
            <asp:Label ID="LBl_Validacion_Ho" runat="server" Text="Debe de seleccionar un Hotel valido" CssClass="alert-warning" Visible="False"></asp:Label>
        </div>
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" Text="Numero de habitacion" Width="180px"></asp:Label>
            <br />
            <input id="INP_Numero_Habi" type="text" runat="server" formmethod="get" style="width: 180px" maxlength="10" />
            <br />
            <asp:Label ID="LBL_Vali_Habi" runat="server" Text="El hotel ya tiene una habitacion con ese numero" CssClass="alert-danger" Visible="False"></asp:Label>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Numero de habitacion requerida" ControlToValidate="INP_Numero_Habi" CssClass="alert-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Label ID="Label6" runat="server" Text="Capacidad Maxima" Width="180px"></asp:Label>
            <br />
            <input id="INP_Cantidad_Max" type="number" runat="server" style="width: 180px" />
            <br />
            <asp:RangeValidator ID="RV_Capacidad" runat="server" ErrorMessage="Debe escoger un valor dentro de los parametros (1-8)" ControlToValidate="INP_Cantidad_Max" CssClass="alert-danger" MaximumValue="8" MinimumValue="1"></asp:RangeValidator>
        </div>
        <div class="form-group">
            <asp:Label ID="Label3" runat="server" Text="Descripcion" Width="180px"></asp:Label>
            <br />
            <input id="INP_Descripcion" type="text" runat="server" formmethod="get" style="width: 180px" maxlength="500" />
            <br />

            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Descripcion requerida" ControlToValidate="INP_Descripcion" CssClass="alert-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="BTN_Guardar" runat="server" Text="Guardar" OnClick="BTN_Guardar_Click" />
            <asp:Button ID="BTN_Regresar" runat="server" Text="Regresar" CausesValidation="False" OnClick="BTN_Regresar_Click" />
        </div>
    </div>
    <style type="text/css">
        #<%= LBL_Crear.ClientID %> {
            color: aqua;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
            font-size:xx-large;
        }
        #<%= Label1.ClientID %> {
            color: aqua;
            font-size: large;
        }
        #<%= Label2.ClientID %>{
            color:aqua;
            font-size:medium;
            text-align:
        } 
        #<%= Label3.ClientID %>{
            color:aqua;
            font-size:medium;
        } 
        #<%= Label6.ClientID %>{
            color:aqua;
            font-size:medium;
        }
        #<%=BTN_Guardar.ClientID%>{
            background-color:blue;
            border-radius: 12px;
            color:white;
            
        }
        #<%=BTN_Guardar.ClientID%>:hover{
            background-color:cyan;
            color:white;
        }
        #<%=BTN_Regresar.ClientID%>{
            background-color:darkgreen; 
            border-radius: 12px;
            color:white;
        }
        #<%=BTN_Regresar.ClientID%>:hover{
            background-color:chartreuse;
            color:white;
        }
    </style>
</asp:Content>
