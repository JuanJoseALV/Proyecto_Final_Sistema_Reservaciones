<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Modificar_Reservacion.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Modificar_Reservacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top:5%">
        <div>
            <asp:Label Text="Crear reservacion" runat="server" id="LBL_Crear" />
        </div>
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Hotel"></asp:Label>
            <br />
            <asp:DropDownList ID="DL_Hotel" runat="server" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
           <asp:Label ID="LBl_Validacion_Ho" runat="server" Text="Debe de seleccionar un Hotel valido" CssClass="alert-warning" Visible="False"></asp:Label>
            <br />
            <asp:Label ID="LBL_Vali_Habi" runat="server" Text="El hotel no tiene habitaciones disponibles por favor seleccione otro" CssClass="alert-danger" Visible="False"></asp:Label>
        </div>
        <div class="form-group">
            <asp:Label ID="Label10" runat="server" Text="Cliente"></asp:Label>
            <br />
            <asp:DropDownList ID="DL_Cliente" runat="server" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
            <asp:Label ID="LBl_Validacion_Usu" runat="server" Text="Debe de seleccionar un usuario valido" CssClass="alert-warning" Visible="False"></asp:Label>
        </div>
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" Text="Fecha de entrada" Width="180px" ></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="Fecha de salida"></asp:Label>
            <br />
            <input id="INP_Fecha_En" type="text"  placeholder="dd/MM/yyyy" runat="server" formmethod="get" style="width:180px" />
            <input id="INP_Fecha_Sal" type="text" placeholder="dd/MM/yyyy" runat="server"  style="width:180px"/>
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
             <input id="INP_Num_A" type="number" runat="server" style="width:180px"/>
            <input id="INP_Num_N" type="number" runat="server"  style="width:180px"/>

        </div>
        <div class="form-group">
            <asp:Button ID="BTN_Guardar" runat="server" Text="Guardar"  OnClick="BTN_Guardar_Click" />
            <asp:Button ID="BTN_Regresar" runat="server" Text="Regresar" CausesValidation="False" OnClick="BTN_Regresar_Click"  />
        </div>
    </div>
    <style type="text/css">
        #<%= LBL_Crear.ClientID %> {
            color: aqua;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
            font-size:xx-large;
        }
        #<%= Label1.ClientID %>{
            color:aqua;
            font-size:large;
        }
        #<%= Label10.ClientID %>{
            color:aqua;
            font-size:large;
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
        #<%= Label7.ClientID %>{
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
