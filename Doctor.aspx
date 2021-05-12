<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Doctor.aspx.cs" Inherits="Doctor" MasterPageFile="~/Site.master" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <link href='css/main.css' type="text/css" rel="stylesheet"/>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <h1>Manage Doctor's Schedule</h1>

    <div class="space">
        Doctor:
        <asp:DropDownList runat="server" ID="DropDownListDoctor" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="DropDownListDoctor_OnSelectedIndexChanged">
            <asp:ListItem Value="NONE">(no doctors specified)</asp:ListItem>
        </asp:DropDownList>
    </div>

    <asp:Panel runat="server" ID="Schedule">
        <div style="display: flex;">
            <div style="margin-right: 10px;">
                <DayPilot:DayPilotNavigator
                    runat="server"
                    ID="DayPilotNavigator1"
                    ClientIDMode="Static"
                    BoundDayPilotID="DayPilotCalendar1"
                    ShowMonths="3"
                    SelectMode="Week"
                    CellHeight="30"
                    CellWidth="30"
                    DayHeaderHeight="30"
                    TitleHeight="30"

                    OnBeforeCellRender="DayPilotNavigator1_OnBeforeCellRender"/>
            </div>

            <div style="flex-grow: 1;">
                <DayPilot:DayPilotCalendar
                    runat="server"
                    ID="DayPilotCalendar1"
                    ClientObjectName="dp"
                    ClientIDMode="Static"
                    ViewType="Week"

                    CellHeight="30"
                    HeaderHeight="30"

                    OnCommand="DayPilotCalendar1_OnCommand"
                    TimeRangeSelectedHandling="CallBack"
                    OnTimeRangeSelected="DayPilotCalendar1_OnTimeRangeSelected"
                    OnBeforeEventRender="DayPilotCalendar1_OnBeforeEventRender"
                    EventClickHandling="JavaScript"
                    EventClickJavaScript="edit(e);"
                    EventMoveHandling="CallBack"
                    OnEventMove="DayPilotCalendar1_OnEventMove"
                    EventResizeHandling="CallBack"
                    OnEventResize="DayPilotCalendar1_OnEventResize"
                    EventDeleteHandling="CallBack"
                    OnEventDelete="DayPilotCalendar1_OnEventDelete"/>
            </div>
        </div>
    </asp:Panel>


    <script>

        function edit(e) {
            var statuses = [
                { name: "Free", id: "free" },
                { name: "Waiting", id: "waiting" },
                { name: "Confirmed", id: "confirmed" }
            ];

            var form = [
                { name: "Start", id: "start", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "End", id: "end", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "Status", id: "status", options: statuses, type: "select" },
                { name: "Name", id: "name" }
            ];

            var data = {
                id: e.id(),
                start: e.start(),
                status: e.tag("AppointmentStatus"),
                name: e.tag("AppointmentPatientName")
            };

            DayPilot.Modal.form(form, data).then(function(modal) {
                if (modal.canceled) {
                    return;
                }
                DayPilot.Http.ajax({
                    url: "Doctor.aspx/Save",
                    data: modal.result,
                    success: function(ajax) {
                        dp.commandCallBack('refresh');
                        dp.message("Saved");
                    }
                });
            });
        }
    </script>
</asp:Content>