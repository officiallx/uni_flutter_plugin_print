package com.evolute.uni_flutter_plugin.utility;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.ArrayList;

public class Utility {

    private Utility() {

    }

    /**
     * Converts ArrayList of integer data to byte array
     *
     * @param data ArrayList<Integer>
     * @return byte[]
     * @throws IOException IOException
     */
    public static byte[] arrayListToByteArray(ArrayList<Integer> data) throws IOException {
        ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
        DataOutputStream out = new DataOutputStream(byteOut);
        for (int element : data) {
            out.write(element);
        }
        return byteOut.toByteArray();
    }
}
