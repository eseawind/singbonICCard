package com.singbon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.entity.Consume;
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
