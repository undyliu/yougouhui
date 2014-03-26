package com.seekon.yougouhui.layout;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;

public class ImageDisplayViewGroup extends ViewGroup {
	private static final int VIEW_MARGIN = 6;
	/**
	 * 每个view上下的间距
	 */
	private int dividerLine = 2;
	/**
	 * 每个view左右的间距
	 */
	private int dividerCol = 2;

	public ImageDisplayViewGroup(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);

	}

	public ImageDisplayViewGroup(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public ImageDisplayViewGroup(Context context) {
		super(context);
	}

	@Override
	protected void onLayout(boolean changed, int l, int t, int r, int b) {

		final int count = getChildCount();
		int row = 0;
		int lengthX = l;
		int lengthY = t;
		for (int i = 0; i < count; i++) {

			final View child = this.getChildAt(i);
			int width = child.getMeasuredWidth();
			int height = child.getMeasuredHeight();
			lengthX += width + VIEW_MARGIN;
			lengthY = row * (height + VIEW_MARGIN) + VIEW_MARGIN + height + t;
			if (lengthX > r) {
				lengthX = width + VIEW_MARGIN + l;
				row++;
				lengthY = row * (height + VIEW_MARGIN) + VIEW_MARGIN + height + t;

			}

			child.layout(lengthX - width, lengthY - height, lengthX, lengthY);
		}
	}

	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
		for (int i = 0; i < getChildCount(); i++) {
			final View child = getChildAt(i);
			child.measure(MeasureSpec.UNSPECIFIED, MeasureSpec.UNSPECIFIED);
		}
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
	}

}