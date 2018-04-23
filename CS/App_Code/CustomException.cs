using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class CustomException : Exception
{
    public CustomException(string message) : base(message) { }
}