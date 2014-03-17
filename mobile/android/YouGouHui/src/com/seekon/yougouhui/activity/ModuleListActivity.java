package com.seekon.yougouhui.activity;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TYPE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import android.database.Cursor;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.module.ModuleConst;
import com.seekon.yougouhui.func.module.ModuleServiceHelper;
import com.seekon.yougouhui.util.RUtils;

public class ModuleListActivity extends RequestListActivity {

	private String type;

	private List<Map<String, ?>> modules = new LinkedList<Map<String, ?>>();

	public ModuleListActivity(String requestResultType, String type) {
		super(requestResultType);
		this.type = type;
	}

	@Override
	protected long initRequestId() {
		return ModuleServiceHelper.getInstance(this).getModules(type, requestResultType);
	}

	@Override
	protected void updateListItems() {
		if (modules.size() == 0) {
			Cursor cursor = getContentResolver().query(
					ModuleConst.CONTENT_URI,
					new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME}, COL_NAME_TYPE + "= ? ", new String[] { type },
					COL_NAME_ORD_INDEX);
			while (cursor.moveToNext()) {
				Map values = new HashMap();
				String code = cursor.getString(1);
				int img = RUtils.getDrawableImg(code);
				if(img == -1){
					img = R.drawable.default_module;
				}
				values.put(COL_NAME_UUID, cursor.getInt(0));
				values.put(COL_NAME_CODE, code);
				values.put(COL_NAME_NAME, cursor.getString(2));
				values.put(COL_NAME_IMG, img);
				modules.add(values);
			}
			cursor.close();
		}
		
		SimpleAdapter adapter = new SimpleAdapter(this, modules,
				R.layout.module_list, new String[] {COL_NAME_IMG, COL_NAME_NAME },
				new int[] { R.id.img, R.id.title });

		this.setListAdapter(adapter);
	}
}
