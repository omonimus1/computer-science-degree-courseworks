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
            // Arrange
            var facadeInstance = new HealthFacade();

            //Act

            // Result should be false because the Category of the staff member does not exists
            Boolean result = facadeInstance.addStaff(11, "Davide", "Pollicino", "Somewhere 2", "in Edinburgh", "Fake category", 3.564, 51.678);
            Boolean valueExpected = false;
            //Assert

            Assert.AreEqual(result, valueExpected);
        }
    }
}