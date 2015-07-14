package com.singbon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.service.ConsumeService;

/**
 * 消费数据记录查询控制类
 * @author 郝威
 *
 */
@Controller
@RequestMapping(value = "/consume")
public class ConsumeController {

	
	@Autowired
	public ConsumeService consumeService;
	
}
