//Zubi C2I Assessment by Infy

pragma solidity^0.6.11;

contract AttendanceSystem{
    address Teacher;
    mapping(address=>string) private studentsmapping;
    mapping(address=>Student) private Studentdata;
    
    constructor() public{
        msg.sender == Teacher;
    }
    
    struct Student{
        string studentName;
        uint attendanceCount;
        bool isRegistered;
        bool isExists;
    }
    
    modifier onlyTeacher(){
        require(msg.sender == Teacher);
        _;
    }
    
    function addStudent(address studentaddress,string memory studentname) public {
        require(Studentdata[studentaddress].isExists != true); // Checking whether same student exist or not.
        studentsmapping[studentaddress] = studentname;
        Student memory newStudent;
        newStudent.studentName = studentname;
        newStudent.isExists = true;
        Studentdata[studentaddress] = newStudent;
    }
    
    function createAttendace(address studentsAddress) public onlyTeacher{
        require(Studentdata[studentsAddress].isExists == true);  // Checking whether same student exist or not in the mapping.
        Studentdata[studentsAddress].attendanceCount++;
        
    }
    
    function validateRegistration(address studentaddress) onlyTeacher public returns (bool success){
        require(Studentdata[studentaddress].isExists == true); // Checking whether same student exist or not in the mapping.
        Studentdata[studentaddress].isRegistered = true;
        return true;
    }

    function getAttendace() public view returns(uint) {
        return Studentdata[msg.sender].attendanceCount;
    }
}
