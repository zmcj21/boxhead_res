using System.Text;
public static class Loader
{
    public class AssetInfo
    {
        public string key;
        public int offset;
        public int length;
        public AssetInfo(string key, int offset, int length)
        {
            this.key = key;
            this.offset = offset;
            this.length = length;
        }
    }

    private static int Decrypt(List<string> lines, byte[] bytes, string outputFolderPath, int curPos)
    {
        List<AssetInfo> assets = new List<AssetInfo>();
        foreach (string line in lines)
        {
            string key = string.Empty;
            int offset = 0;
            string[] items = line.Split(',');
            foreach (string item in items)
            {
                string[] key_value_pair = item.Split(':');
                switch (key_value_pair[0])
                {
                    case "key":
                        key = key_value_pair[1];
                        break;
                    case "offset":
                        offset = int.Parse(key_value_pair[1]);
                        break;
                }
            }
            AssetInfo asset = new AssetInfo(key, offset, 0);
            assets.Add(asset);
        }
        int i = 0;
        for (; i < assets.Count - 1; i++)
        {
            assets[i].length = assets[i + 1].offset - assets[i].offset;
            byte[] arr = new byte[assets[i].length];
            for (int x = 0; x < arr.Length; x++)
            {
                arr[x] = 0;
            }
            Array.Copy(bytes, curPos + assets[i].offset, arr, 0, assets[i].length);
            if (assets[i].key.LastIndexOf("\\") != -1)
            {
                string directoryPath = outputFolderPath + assets[i].key.Substring(0, assets[i].key.LastIndexOf("\\"));
                if (!File.Exists(directoryPath)) Directory.CreateDirectory(directoryPath);
            }
            string savePath = outputFolderPath + assets[i].key;
            using (FileStream fileStream = File.Create(savePath))
            {
                fileStream.Write(arr, 0, arr.Length);
            }
            Console.WriteLine(savePath);
        }
        return i;
    }

    public static void Main(string[] parameters)
    {
        if (parameters.Length != 2)
        {
            Console.WriteLine("Parameters error!");
            Console.ReadLine();
            return;
        }
        string inputFilePath = parameters[0];
        string outputFolderPath = parameters[1];
        byte[] bytes = File.ReadAllBytes(inputFilePath);
        using (FileStream stream = File.Open(inputFilePath, FileMode.Open, FileAccess.ReadWrite))
        {
            using (BinaryReader reader = new BinaryReader(stream))
            {
                uint strLen = reader.ReadUInt32();
                int curPos = sizeof(uint) + (int)strLen;
                byte[] strBytes = reader.ReadBytes((int)strLen);

                string str = Encoding.UTF8.GetString(strBytes);
                string[] origin_strs = str.Split(new char[] { '/', '{', '|', '}' });

                List<string> lines = new List<string>();
                foreach (string item in origin_strs)
                {
                    if (item.Equals("") || item.Equals(",") || lines.Contains(item)) continue;
                    lines.Add(item);
                }
                int createCount = Decrypt(lines, bytes, outputFolderPath, curPos);
                Console.WriteLine($"Decrypt finish:{createCount}.");
            }
        }
        Console.ReadLine();
    }
}