package com.seekon.yougouhui.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.GridView;

public class NestedGridView extends GridView {

	public NestedGridView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public NestedGridView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public NestedGridView(Context context) {
		super(context);
	}

	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		// TODO Auto-generated method stub
		int expandSpec = MeasureSpec.makeMeasureSpec(Integer.MAX_VALUE >> 2,
				MeasureSpec.AT_MOST);
		super.onMeasure(widthMeasureSpec, expandSpec);
	}
}
