﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Serialization;

public static class Utils
{

    public static uint NextUInt32(this Random rand)
    {
        return (uint)(rand.Next(1 << 30)) << 2 | (uint)(rand.Next(1 << 2));
    }
    public static int FromString(string x)
    {
        if (String.IsNullOrWhiteSpace(x)) return 0;
        if (x.StartsWith("0x")) return int.Parse(x.Substring(2), NumberStyles.HexNumber);
        return int.Parse(x);
    }

    public static List<int> StringListToIntList(List<string> strList)
    {
        var ret = new List<int>();
        foreach (string i in strList)
        {
            if (String.IsNullOrWhiteSpace(i))
            {
                ret.Add(0);
                continue;
            }
            ret.Add(FromString(i));
        }
        return ret;
    }

    public static string To4Hex(short x)
    {
        return "0x" + x.ToString("x4");
    }

    public static string GetCommaSepString<T>(T[] arr)
    {
        var ret = new StringBuilder();
        for (int i = 0; i < arr.Length; i++)
        {
            if (i != 0) ret.Append(", ");
            ret.Append(arr[i]);
        }
        return ret.ToString();
    }

    public static int[] FromCommaSepString32(string x)
    {
        return x.Split(',').Select(_ => FromString(_.Trim())).ToArray();
    }

    public static ushort[] FromCommaSepString16(string x)
    {
        return x.Split(',').Select(_ => (ushort) FromString(_.Trim())).ToArray();
    }

    public static string[] FromCommaSepString(string x)
    {
        return x.Split(',').Select(_ => _.Trim()).ToArray();
    }

    public static void Shuffle<T>(this IList<T> list)
    {
        var provider = new RNGCryptoServiceProvider();
        int n = list.Count;
        while (n > 1)
        {
            var box = new byte[1];
            do provider.GetBytes(box); while (!(box[0] < n*(Byte.MaxValue/n)));
            int k = (box[0]%n);
            n--;
            T value = list[k];
            list[k] = list[n];
            list[n] = value;
        }
    }

    public static string ToSafeText(this string str)
    {
        return Encoding.ASCII.GetString(
            Encoding.Convert(
                Encoding.UTF8,
                Encoding.GetEncoding(
                    Encoding.ASCII.EncodingName,
                    new EncoderReplacementFallback(string.Empty),
                    new DecoderExceptionFallback()
                    ),
                Encoding.UTF8.GetBytes(str)
                )
            );
    }
}

public struct XmlBool : IXmlSerializable
{
    private bool m_value;

    public XmlBool(bool value)
    {
        m_value = value;
    }

    public static bool operator ==(XmlBool a, object b)
    {
        if (b == null) return false;
        return a.m_value == (bool)b;
    }

    public static bool operator !=(XmlBool a, object b)
    {
        return !(a == b);
    }

    public static implicit operator XmlBool(bool value)
    {
        return new XmlBool { m_value = value };
    }

    public static implicit operator bool (XmlBool value)
    {
        return value.m_value;
    }

    public bool Equals(XmlBool other)
    {
        return m_value == other.m_value;
    }

    public override bool Equals(object obj)
    {
        if (ReferenceEquals(null, obj)) return false;
        return obj is XmlBool && Equals((XmlBool)obj);
    }

    public override int GetHashCode()
    {
        return m_value.GetHashCode();
    }

    public XmlSchema GetSchema() { return null; }
    public void ReadXml(XmlReader reader) { m_value = true; }
    public void WriteXml(XmlWriter writer) { }
}