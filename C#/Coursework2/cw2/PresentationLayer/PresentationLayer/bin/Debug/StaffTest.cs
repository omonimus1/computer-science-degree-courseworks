using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace BusinessLayer.UnitTestProject1
{
    [TestClass]
    public class StaffTest
    {
        [TestMethod]
        public void CanNewStaffBeAdded()
        {
            // The following structure is called 3 A

            // Arrange -> we create the object
            var facadeInstance = new HealthFacade();

            //Act -> part where we call the test that we have to test
            Boolean result = facadeInstance.testStaff();
            Boolean valueExpected = false; 
            //Assert
            
           Assert.AreEqual(result, valueExpected);
           // Console.WriteLine("cdcd");
               // Console.WriteLine("The staff has not being added because the staff category indicated is not valid")
        }
    }
} 
