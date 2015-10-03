package com.singbon.util;

import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 * 文件导出
 * 
 * @author 郝威
 * 
 */
public class ExportUtil {

	public static void exportExcel(String filename, String[] columns, List<List<String>> list, HttpServletResponse response) {
		try {
			response.setHeader("Content-Disposition", "attachment;filename=" + new String((filename + ".xls").getBytes("UTF-8"), "iso-8859-1"));
			response.setCharacterEncoding("utf-8");
			//
			int maxRow = 65535;
			HSSFWorkbook workbook = new HSSFWorkbook();
			int sheetNum = list.size() / maxRow;
			if (list.size() % maxRow > 0) {
				sheetNum += 1;
			}
			for (int i = 0; i < sheetNum; i++) {
				// sheet
				HSSFSheet sheet = workbook.createSheet("sheet" + (i + 1));
				// columns
				HSSFRow colRow = sheet.createRow(0);
				HSSFCell cell;
				for (int j = 0; j < columns.length; j++) {
					cell = colRow.createCell(j);
					cell.setCellValue(columns[j]);
				}
				// data
				for (int k = i * maxRow; k < list.size(); k++) {
					List<String> dataList = list.get(k);
					colRow = sheet.createRow(k % maxRow + 1);
					for (int m = 0; m < dataList.size(); m++) {
						cell = colRow.createCell(m);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(dataList.get(m));
					}
					if ((k + 1) % maxRow == 0) {
						break;
					}
				}
			}

			OutputStream bos = response.getOutputStream();
			workbook.write(bos);
			bos.flush();
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
