package com.tradplus.flutter.nativead;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.tradplus.flutter.Const;
import com.tradplus.flutter.TPUtils;
import com.tradplus.flutter.TradPlusSdk;

import java.util.Map;

public class TPNativeViewInfo {


    public static boolean addToParentView(final FrameLayout view, final View childView, final Map<String, Object> map, final int gravity) {
        if (view == null || map == null) {
            return false;
        }


        ///宽高默认自适应
        int width = FrameLayout.LayoutParams.WRAP_CONTENT;
        int height = FrameLayout.LayoutParams.WRAP_CONTENT;




        if ((double) map.get(Const.WIDTH) > 0) {
            width = TPUtils.dip2px(childView.getContext(), (double) map.get(Const.WIDTH));
        }

        if ((double) map.get(Const.HEIGHT) > 0) {
            height = TPUtils.dip2px(childView.getContext(), (double) map.get(Const.HEIGHT));
        }


        ///设置layout宽高
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(width, height);

        int x = TPUtils.dip2px(childView.getContext(), (double) map.get(Const.X));
        int y = TPUtils.dip2px(childView.getContext(), (double) map.get(Const.Y));


        layoutParams.leftMargin = x;
        layoutParams.topMargin = y;
        if (gravity > 0) {
            layoutParams.gravity = gravity;
        } else {
            layoutParams.gravity = 51;
        }


        childView.setLayoutParams(layoutParams);

        ///下面设置属性
        try {
            String bgcolor = (String) map.get(Const.BACKGROUND_COLOR);
            String textColor = (String) map.get(Const.TEXT_COLOR);
            double textSize = (double) map.get(Const.TEXT_SIZE);
            boolean isCenter = (boolean) map.get(Const.TEXT_CENTER);
            int textLines = (int) map.get(Const.TEXT_LINES);


            if (!TextUtils.isEmpty(bgcolor)) {
                childView.setBackgroundColor(Color.parseColor(bgcolor));
            }
            if (childView instanceof TextView) {
                if (!TextUtils.isEmpty(textColor)) {
                    ((TextView) childView).setTextColor(Color.parseColor(textColor));
                }
                if (textSize > 0) {
                    ((TextView) childView).setTextSize((float) textSize);
                }
                if (isCenter) {
                    ((TextView) childView).setGravity(Gravity.CENTER);
                }
                if(textLines>0){
                    ((TextView) childView).setMaxLines(textLines);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        view.addView(childView, layoutParams);


        return (boolean) map.get(Const.CUSTOM_CLICK);
    }

}
