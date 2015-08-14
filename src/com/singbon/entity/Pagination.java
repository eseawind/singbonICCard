package com.singbon.entity;

import java.io.Serializable;

/**
 * 分页实体类
 * 
 * @author 郝威
 * 
 */
public class Pagination implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer pageNum;
	private Integer numPerPage;
	private Integer totalCount;
	private Integer offset;

	public Integer getPageNum() {
		if (totalCount != null) {
			int totalPageNum = totalCount / numPerPage;
			if (totalCount % numPerPage > 0) {
				totalPageNum += 1;
			}
			if (pageNum > totalPageNum) {
				pageNum = totalPageNum;
			}
			if (pageNum < 1) {
				pageNum = 1;
			}
		}
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(Integer numPerPage) {
		this.numPerPage = numPerPage;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public Integer getOffset() {
		offset = (getPageNum() - 1) * numPerPage;
		return offset;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}

}
