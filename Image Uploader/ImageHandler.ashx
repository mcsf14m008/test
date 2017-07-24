<%@ WebHandler Language="C#" Class="ImageHandler" %>

using System;
using System.Web;
using System.IO;


public class ImageHandler : IHttpHandler
{
    

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public void ProcessRequest(HttpContext context)
    {
        try
        {

            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                string fileName = "", ImageDirectory = "~/Images/EventImages/";
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];
                    //file.FileName = DateTime.Now.Ticks + file.FileName;
                    ImageDirectory = context.Server.MapPath(ImageDirectory);
                    if (!Directory.Exists(ImageDirectory))
                        Directory.CreateDirectory(ImageDirectory);
                    //string fname = context.Server.MapPath(ImageDirectory + file.FileName);
                    fileName = ImageDirectory + file.FileName;
                    file.SaveAs(fileName);
                }
                context.Response.ContentType = "text/plain";
                context.Response.Expires = -1;
                context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
                context.Response.StatusCode = 200;
                context.Response.Write(fileName);

            }
            else
            {
                context.Response.StatusCode = 400;
            }
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            context.Response.Write("Exception :" + ex);
        }

    }

}