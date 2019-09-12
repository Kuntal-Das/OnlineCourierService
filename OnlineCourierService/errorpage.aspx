<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="errorpage.aspx.cs" Inherits="OnlineCourierService.errorpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=3.0, minimum-scale=0.86" />
    <link rel="shortcut icon" href="lightning.ico">
    <title>Error</title>
    <style>
        *{
            padding:0px;
            margin:0px;
            box-sizing:border-box;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin:10px; border:2px solid black">
            <h1 style="color:red; margin:20px;">Application Error</h1>
            <h3 style="margin:10px 10px 10px 20px;">An unkown error has occured. We are aware of it and the IT team is currently working<br />
                this issue. Sorry for the inconvinience caused.</h3>
        </div>
    </form>
</body>
</html>
