<%@ WebHandler Language="C#" Class="Download" %>

using System;
using System.Web;
using System.IO;
public class Download : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string fileName = context.Request.QueryString["filename"];
        try
        {
            context.Response.ContentType = "image";
            var file = context.Server.MapPath("~/images/eventimages/" + fileName);
            context.Response.TransmitFile(file);
            //FileStream stream = File.OpenRead(file);
            //// stream the data from the file to  the response
            //int b;
            //context.Response.Clear();
            //context.Response.ClearHeaders();
            //while ((b = stream.ReadByte()) != -1)
            //{
            //    context.Response.OutputStream.WriteByte((byte)b);
            //}
            //context.Response.OutputStream.Flush();

        }
        catch (Exception ex)
        {
            context.Response.Write("Invalid file name");
            context.Response.StatusCode = 400;

        }



    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}