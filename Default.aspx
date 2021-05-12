<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" MasterPageFile="~/Site.master" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <h1>Request an Appointment</h1>

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
            <p>Available time slots:</p>
            <DayPilot:DayPilotCalendar
                runat="server"
                ID="DayPilotCalendar1"
                ClientIDMode="Static"
                ClientObjectName="dp"
                ViewType="Week"

                DurationBarWidth="10"
                CellHeight="30"
                HeaderHeight="30"

                OnCommand="DayPilotCalendar1_OnCommand"
                OnBeforeEventRender="DayPilotCalendar1_OnBeforeEventRender"

                EventClickHandling="JavaScript"
                EventClickJavaScript="edit(e)"/>
        </div>
    </div>


    <script>
        function edit(e) {
            new DayPilot.Modal({
                onClosed: function(args) {
                    if (args.result == "OK") {
                        dp.commandCallBack('refresh');
                    }
                }
            }).showUrl("Request.aspx?id=" + e.id());
        }


        function edit(e) {
            var form = [
                { name: "Start", id: "start", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "End", id: "end", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "Your name", id: "name" },
            ];

            var data = {
                id: e.id(),
                start: e.start(),
                end: e.end()
            };

            DayPilot.Modal.form(form, data).then(function(modal) {
                if (modal.canceled) {
                    return;
                }
                DayPilot.Http.ajax({
                    url: "Default.aspx/SaveRequest",
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