/**
 * @author Mika Ropponen
 */
package fi.softala.ttl.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Group implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int groupID;
	private String groupName;
	private String groupKey;
	private List<User> instructors;

	public Group() {
		super();
		this.groupID = 0;
		this.groupName = "";
		this.groupKey = "";
		this.instructors = new ArrayList<User>();
	}
	
	public Group(int groupID, String groupName, String groupKey, List<User> instructors) {
		super();
		this.groupID = groupID;
		this.groupName = groupName;
		this.groupKey = groupKey;
		this.instructors = instructors;
	}
	
	public void reset() {
		this.groupID = 0;
	}

	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public String getGroupKey() {
		return groupKey;
	}

	public void setGroupKey(String groupKey) {
		this.groupKey = groupKey;
	}

	public List<User> getInstructors() {
		return instructors;
	}

	public void setInstructors(List<User> instructors) {
		this.instructors = instructors;
	}

}
