package com.softline.client.bima;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Java class for getUsersEntity01Response complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType name="getUsersEntity01Response">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="return" type="{http://webService.softline.com/}hhUsers" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getUsersEntity01Response", propOrder = { "_return" })
public class GetUsersEntity01Response {

	@XmlElement(name = "return")
	protected HhUsers _return;

	/**
	 * Gets the value of the return property.
	 * 
	 * @return possible object is {@link HhUsers }
	 * 
	 */
	public HhUsers getReturn() {
		return _return;
	}

	/**
	 * Sets the value of the return property.
	 * 
	 * @param value
	 *            allowed object is {@link HhUsers }
	 * 
	 */
	public void setReturn(HhUsers value) {
		this._return = value;
	}

}
