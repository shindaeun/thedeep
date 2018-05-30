package com.siot.IamportRestHttpClientJava.response;

import java.util.List;

public class Payments {
	private int total,previous,next;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPrevious() {
		return previous;
	}
	public void setPrevious(int previous) {
		this.previous = previous;
	}
	public int getNext() {
		return next;
	}
	public void setNext(int next) {
		this.next = next;
	}
	private List<Payment> list;
	
	public List<Payment> getList() {
		return list;
	}
	public void setList(List<Payment> list) {
		this.list = list;
	}
}
